set print pretty on
set confirm off
set verbose off
#set prompt \033[31mgdb$ \033[0m
set prompt gdb> 

set output-radix 0x10
set input-radix 0x10

set history save on
set history filename ~/.gdb_history
set history size 500
#set history size unlimited

set logging file ~/gdb.log
# append or overwrite?
set logging overwrite on
set logging on
show logging

# These make gdb never pause in its output
set height 0
set width 0

# Display instructions in Intel format
set disassembly-flavor intel

thread apply all bt full
set follow-fork-mode child

##
## General use definitions
##

#macro define offsetof(t, f) (int)(& ((t *) 0)->f)
macro define offsetof(t, f) ( (int)&(((t *) 0)->f) )

# Show info on the current thread
define kcurr
  set $_stk = (struct thread_info *)((unsigned long)$esp & 0xffffe000)
  printf "Kernel stack %p: task %s [%d]\n", $_stk, $_stk.task.comm, $_stk.task.pid
end

# Show the current process' memory map
define showmmap
   kcurr
   set $_currvma = $_stk.task.mm.mmap

   printf "brk  [%08lx - %08lx]\n", $_stk.task.mm.start_brk,  $_stk.task.mm.brk
   printf "code [%08lx - %08lx]\n", $_stk.task.mm.start_code, $_stk.task.mm.end_code
   printf "data [%08lx - %08lx]\n", $_stk.task.mm.start_data, $_stk.task.mm.end_data
   printf "arg  [%08lx - %08lx]\n", $_stk.task.mm.arg_start,  $_stk.task.mm.arg_end 
   printf "env  [%08lx - %08lx]\n", $_stk.task.mm.env_start,  $_stk.task.mm.env_start 
   printf "stk  [%08lx - ?]\n",     $_stk.task.mm.start_stack 

   while( $_currvma )
      printf "[%08lx - %08lx) flags %08lx prot %016lx\n", $_currvma.vm_start, \
        $_currvma.vm_end, $_currvma.vm_flags, $_currvma.vm_page_prot.pgprot 
      set $_currvma = $_currvma.vm_next
   end
end

# Delete the 0xcc upon arrival at a compiled-in breakpoint
define delbp
  set $_intaddr = (unsigned long long)$rip - 1
  printf "Clobbering int3 @ %p\n", $_intaddr
  set *(unsigned char *) $_intaddr = 0x90
end

# Put an int3 at the address given. Complements delbp above.
define setbp
  set *(uint8_t *)$arg0 = 0xcc
end

# Is the current exception from our module? Pass in base addr of
# module and check whether the first several bits match. IP at offset
# 1 when error is given.
define modexc
  set $_excip = ((unsigned long *)$sp)[1] 
  set $_inmod = ((unsigned long)$_excip >> 0d20) == ((unsigned long)$arg0 >> 0d20)
end

# Continues if not in module
define contifnmod
  modexc $arg0
  if !$_inmod
    continue
  end
end

define contifnapp
  kcurr
  if $_stk.task.pid != $arg0
    continue
  end
end


define replace_ctx32
  set $_pt = $arg0
  set $_bx = $_pt.bx
  set $_cx = $_pt.cx
  set $_dx = $_pt.dx
  set $_si = $_pt.si
  set $_di = $_pt.di
  set $_bp = $_pt.bp
  set $_ax = $_pt.ax
  set $_ds = $_pt.ds
  set $_es = $_pt.es
  set $_fs = $_pt.fs
  set $_gs = $_pt.gs
  set $_ip = $_pt.ip
  set $_cs = $_pt.cs
  set $_fl = $_pt.flags
  set $_sp = $_pt.sp
  set $_ss = $_pt.ss

  set $ebx = $_bx
  set $ecx = $_cx
  set $edx = $_dx
  set $esi = $_si
  set $edi = $_di
  set $ebp = $_bp
  set $eax = $_ax
  set $ds = $_ds
  set $es = $_es
  set $fs = $_fs
  set $gs = $_gs
  set $eip = $_ip
  set $cs = $_cs
  set $eflags = $_fl
  set $esp = $_sp
  set $ss = $_ss
end
document replace_ctx
  Syntax: replace_ctx <pt_regs *>
  | Replaces the register context with that in the given pt_regs struct.
  | Helpful for identifying source of exceptions from within handler.
  | Destructive function.
end

source ~/.gdbinit.local
