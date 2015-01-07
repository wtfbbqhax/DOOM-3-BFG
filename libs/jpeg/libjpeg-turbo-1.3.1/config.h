// DG: adjusted to hopefully support all our targets

/* Build number */
#define BUILD "20150107"

/* Support arithmetic encoding */
#define C_ARITH_CODING_SUPPORTED 1

/* Support arithmetic decoding */
#define D_ARITH_CODING_SUPPORTED 1

/* Define to 1 if you have the <dlfcn.h> header file. */
#ifdef _WIN32 // DG: windows doesn't.
#undef HAVE_DLFCN_H
#else
#define HAVE_DLFCN_H 1
#endif

/* Define to 1 if you have the <inttypes.h> header file. */
#if defined(_MSC_VER) && _MSC_VER < 1800 // DG: VS only supports this with VS2013 and newer
#undef HAVE_INTTYPES_H 
#else
#define HAVE_INTTYPES_H 1
#endif


/* Define to 1 if you have the <jni.h> header file. */
/* #undef HAVE_JNI_H */

/* Define to 1 if you have the `memcpy' function. */
#define HAVE_MEMCPY 1

/* Define to 1 if you have the <memory.h> header file. */
#define HAVE_MEMORY_H 1

/* Define to 1 if you have the `memset' function. */
#define HAVE_MEMSET 1

/* Define if your compiler supports prototypes */
#define HAVE_PROTOTYPES 1

/* Define to 1 if you have the <stddef.h> header file. */
#define HAVE_STDDEF_H 1

/* Define to 1 if you have the <stdint.h> header file. */
#ifdef _MSC_VER
#undef HAVE_STDINT_H
#else
#define HAVE_STDINT_H 1
#endif

/* Define to 1 if you have the <stdlib.h> header file. */
#define HAVE_STDLIB_H 1

/* Define to 1 if you have the <strings.h> header file. */
#define HAVE_STRINGS_H 1

/* Define to 1 if you have the <string.h> header file. */
#define HAVE_STRING_H 1

/* Define to 1 if you have the <sys/stat.h> header file. */
#define HAVE_SYS_STAT_H 1

/* Define to 1 if you have the <sys/types.h> header file. */
#define HAVE_SYS_TYPES_H 1

/* Define to 1 if you have the <unistd.h> header file. */
#ifdef _WIN32 // DG: windows doesn't ...
#undef HAVE_UNISTD_H
#else
#define HAVE_UNISTD_H 1
#endif

/* Define to 1 if the system has the type `unsigned char'. */
#define HAVE_UNSIGNED_CHAR 1

/* Define to 1 if the system has the type `unsigned short'. */
#define HAVE_UNSIGNED_SHORT 1

/* Compiler does not support pointers to undefined structures. */
/* #undef INCOMPLETE_TYPES_BROKEN */

/* How to obtain function inlining. */
#ifdef __GNUC__ // gcc, clang - DG: adjusted to also support MSVC
#define INLINE inline __attribute__((always_inline))
#else
#define INLINE inline
#endif

/* libjpeg API version */
#define JPEG_LIB_VERSION 80

/* libjpeg-turbo version */
#define LIBJPEG_TURBO_VERSION 1.3.1

/* Support in-memory source/destination managers */
/* #undef MEM_SRCDST_SUPPORTED */

/* Define if you have BSD-like bzero and bcopy */
/* #undef NEED_BSD_STRINGS */

/* Define if you need short function names */
/* #undef NEED_SHORT_EXTERNAL_NAMES */

/* Define if you have sys/types.h */
#define NEED_SYS_TYPES_H 1

/* Define to 1 if your C compiler doesn't accept -c and -o together. */
/* #undef NO_MINUS_C_MINUS_O */

/* Name of package */
#define PACKAGE "libjpeg-turbo"

/* Define to the address where bug reports for this package should be sent. */
#define PACKAGE_BUGREPORT ""

/* Define to the full name of this package. */
#define PACKAGE_NAME "libjpeg-turbo"

/* Define to the full name and version of this package. */
#define PACKAGE_STRING "libjpeg-turbo 1.3.1"

/* Define to the one symbol short name of this package. */
#define PACKAGE_TARNAME "libjpeg-turbo"

/* Define to the version of this package. */
#define PACKAGE_VERSION "1.3.1"

/* Define if shift is unsigned */
/* #undef RIGHT_SHIFT_IS_UNSIGNED */

/* The size of a `long', as computed by sizeof. */
#define SIZEOF_LONG sizeof(long) // DG: yeah.

/* Define to 1 if you have the ANSI C header files. */
#define STDC_HEADERS 1

/* Version number of package */
#define VERSION "1.3.1"

/* Use accelerated SIMD routines. */
// #define WITH_SIMD 1 
#undef WITH_SIMD // DG: don't, for now

/* Define to 1 if type `char' is unsigned and you are not using gcc.  */
#ifndef __CHAR_UNSIGNED__
/* # undef __CHAR_UNSIGNED__ */
#endif

/* Define to empty if `const' does not conform to ANSI C. */
/* #undef const */

/* Define to `__inline__' or `__inline' if that's what the C compiler
   calls it, or to nothing if 'inline' is not supported under any name.  */
#ifndef __cplusplus
/* #undef inline */
#endif

/* Define to `unsigned' if <sys/types.h> does not define. */
/* #undef size_t */
