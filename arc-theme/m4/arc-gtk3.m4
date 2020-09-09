# ARC_GTK3()
# ---------------
AC_DEFUN([ARC_GTK3], [
    GTK3DIR="$srcdir/common/gtk-3.0"
    PKG_PROG_PKG_CONFIG()
    AC_ARG_WITH(
        [gtk3],
        [AS_HELP_STRING(
            [--with-gtk3],
            [GTK3 version]
        )],
        [GTK3_VERSION="$withval"],
        [PKG_CHECK_EXISTS(
            [gtk+-3.0],
            [GTK3_VERSION=`$PKG_CONFIG --modversion gtk+-3.0`]
            AC_MSG_RESULT([Detected GTK3 $GTK3_VERSION]),
            [AC_MSG_ERROR([Could not determine GTK3 version. Install GTK3 (and its development files), or use the --with-gtk3=<version> option. Alternatively you can choose to not build the GTK3 theme with --disable-gtk3 option.])]
        )]
    )

    # Trim version extras
    GTK3_VERSION=`echo $GTK3_VERSION | cut -d. -f-2`

    # Extra major and minor version components
    GTK3_VERSMJR=`echo $GTK3_VERSION | cut -d. -f1`
    GTK3_VERSMNR=`echo $GTK3_VERSION | cut -d. -f2`

    AS_IF(
        [test "x$GTK3_VERSMJR" != x3], [AC_MSG_ERROR([Invalid GTK3 version: $GTK3_VERSION])],
        [test "0$GTK3_VERSMNR" -lt 17], [AC_MSG_ERROR([GTK3 version too old: $GTK3_VERSION])],
        [test "0$GTK3_VERSMNR" -lt 19], [GTK3_VERSION=3.18],
        [test "0$GTK3_VERSMNR" -ge 19 -a "0$GTK3_VERSMNR" -lt 21], [GTK3_VERSION=3.20],
        [test "0$GTK3_VERSMNR" -ge 21 -a "0$GTK3_VERSMNR" -lt 23], [GTK3_VERSION=3.22],
        [test "0$GTK3_VERSMNR" -ge 23], [GTK3_VERSION=3.24]
    )
    AC_SUBST([GTK3_VERSION])
    AC_SUBST([gtk3themedir], [${themedir}/gtk-3.0])
    AC_SUBST([gtk3themedarkerdir], [${themedarkerdir}/gtk-3.0])
    AC_SUBST([gtk3themedarkdir], [${themedarkdir}/gtk-3.0])
    AC_SUBST([gtk3themelighterdir], [${themelighterdir}/gtk-3.0])
    AC_MSG_RESULT([Building GTK3 theme $GTK3_VERSION])
])
