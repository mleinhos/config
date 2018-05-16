#ifndef kbasic_defs_h
#define kbasic_defs_h

#if (defined MYDEBUG)

#   define VERBOSE(fmt, ...)					\
    do {                                        \
        if ( MYVERBOSE )						\
            pr_debug( fmt, ##__VA_ARGS__ );     \
    } while(0)

#  define VERBOSE_RAW(fmt, ...)							\
    do {												\
        if ( MYVERBOSE )								\
            printk( KERN_DEBUG fmt, ##__VA_ARGS__ );	\
    } while(0)

#  define DEBUG(fmt, ...)						\
    do {                                        \
		pr_debug( fmt, ##__VA_ARGS__ );			\
    } while(0)

#  define DEBUG_RAW(fmt, ...)						\
    do {											\
		printk( KERN_DEBUG fmt, ##__VA_ARGS__ );	\
    } while(0)

#   define PRINT_RAW(lvl, fmt, ...)				\
    do {										\
		printk( lvl fmt, ##__VA_ARGS__ );       \
    } while(0)

#else // MYDEBUG

#   define VERBOSE(fmt, ...)          ((void)0)
#   define VERBOSE_RAW(fmt, ...)      ((void)0)
#   define DEBUG(fmt, ...)            ((void)0)
#   define DEBUG_RAW(fmt, ...)        ((void)0)
#   define PRINT_RAW(lvl, fmt, ...)   ((void)0)

#endif // MYDEBUG

#define PRINT(lvl, fmt, ...)						\
    do {											\
		printk( lvl pr_fmt(fmt), ##__VA_ARGS__ );	\
    } while(0)


//
// Debugging helpers
//

#define _DEBUG_BREAK_ASM_STRING "int $3\n"
#define _DEBUG_EMIT_BREAKPOINT()  asm( _DEBUG_BREAK_ASM_STRING )

#ifdef MYTRAP
#  define DEBUG_EMIT_BREAKPOINT()               \
    _DEBUG_EMIT_BREAKPOINT()
#else
#  define DEBUG_EMIT_BREAKPOINT() ((void)0)
#endif

#define DEBUG_BREAK() DEBUG_EMIT_BREAKPOINT()

#define _ASSERT(_x)												\
	do {														\
		if (_x) break;											\
		pr_emerg( "### ASSERTION FAILED %s: %s: %d: %s\n",		\
				  __FILE__, __func__, __LINE__, #_x);			\
		dump_stack();											\
		DEBUG_BREAK();											\
	} while (0)

// Always check asserts, for now...
#define MYASSERT(_x) _ASSERT( (_x) )

#define MYASSERT_RAW(_x)                            \
        do {                                        \
            if ( !(_x) ) {                          \
                _DEBUG_EMIT_BREAKPOINT();           \
            }                                       \
        } while( 0 )


#define bzero(p, sz) __memset_generic( (p), 0, (sz) )
#define memcpy(dest, src, sz) __memcpy( (dest), (src), (sz) )

#define KFREE_RESET(_x)    if ( NULL != (_x) ) { kfree( (_x) ); (_x) = NULL; }

#define IS_KERNEL_ADDR(_x) ((unsigned long)(_x) >= TASK_SIZE)
#define IS_USER_ADDR(_x)   (!IS_KERNEL_ADDR((_x)))

#define ADDR_IN_RANGE(_x, _base, _len)                  \
    ( (addr_t)(_base) <= (addr_t)(_x) &&                \
      (addr_t)(_x) < (addr_t)(_base) + (int)(_len) )


// The optimizer makes debugging a pain. Here's an easy way to disable
// optimization on a per-function basis.
#ifdef MYDEBUG
#   define DISABLE_OPT __attribute__((optimize("O0")))
#else
#   define DISABLE_OPT
#endif


#endif // kbasic_defs_h
