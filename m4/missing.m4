## missing.m4 -*- autoconf -*- vim: filetype=config
##
## $Id$
##
## Written by Keith Marshall <keithmarshall@users.sourceforge.net>
## Copyright (C) 2010, MinGW Project
##
##
## Autoconf macros to gracefully abort configure, on identified
## non-availability of specified build prerequisites.
##
##
## This is free software.  Permission is hereby granted to copy
## and redistribute this software, either as is or in modified form,
## subject only to the restrictions that the original author's notice
## of copyright and disclaimers of warranty and of liability shall be
## preserved without change in EVERY copy, and that modified copies
## shall be clearly identified as such.
##
## This software is provided "as is", in the hope that it may prove
## useful, but there is NO WARRANTY OF ANY KIND; not even an implied
## WARRANTY OF MERCHANTABILITY, nor of FITNESS FOR A PARTICULAR PURPOSE.
## Under no circumstances will the author, or the MinGW Project, accept
## liability for any damages, however caused, arising from the use of
## this software.


# MINGW_AC_ASSERT_MISSING( PACKAGE, [TARNAME] )
# ---------------------------------------------
# Add PACKAGE to the list of prerequisite packages which are
# identified as missing from the build system; this will then
# be included in the diagnostic message which will be displayed,
# if MINGW_AC_ABORT_IF_MISSING_PREREQ is subsequently invoked.
#
# If TARNAME is also specified, then it too will be included
# in the message, as a recommended package to be installed in
# order to satisfy the prerequisite.
#
AC_DEFUN([MINGW_AC_ASSERT_MISSING],
[test -n "${mingw_ac_missing_list}" && {
  mingw_ac_missing_plural=s mingw_ac_missing_appear=; }
 mingw_ac_missing_list="${mingw_ac_missing_list}
  $1"
 test -n "$2" && { test -n "${mingw_ac_missing_providers}" && {
  mingw_ac_missing_providers_plural=s; }
  mingw_ac_missing_providers="${mingw_ac_missing_providers}
  $2"; }
])# MINGW_AC_ASSERT_MISSING

# MINGW_AC_ABORT_IF_MISSING_PREREQ
# --------------------------------
# Invoked unconditionally after any MINGW_AC_ASSERT_MISSING request,
# and prior to AC_OUTPUT, causes configure to abort with a diagnostic
# message if any missing prerequisite has been identified.
#
AC_DEFUN([_MINGW_AC_ABORT_IF_MISSING_PREREQ],
[test -n "$mingw_ac_missing_list" && { _MINGW_AC_SUGGEST_PROVIDERS
 AC_MSG_ERROR([missing prerequisite${mingw_ac_missing_plural}:

The following prerequisite package${mingw_ac_missing_plural} dnl
appear${mingw_ac_missing_appear-s} to be missing from
your system:--
${mingw_ac_missing_list}]); }
])# MINGW_AC_ABORT_IF_MISSING_PREREQ

# _MINGW_AC_SUGGEST_PROVIDERS
# ---------------------------
# Helper macro, invoked only by MINGW_AC_ABORT_IF_MISSING_PREREQ;
# it causes any TARNAME references from MINGW_AC_ASSERT_MISSING to
# be itemised in the diagnostic output.
#
AC_DEFUN([_MINGW_AC_SUGGEST_PROVIDERS],
[test -n "${mingw_ac_missing_providers}" && {
  test -z "${mingw_ac_missing_providers_plural}" \
    && mingw_ac_newer="a newer" \
    || mingw_ac_newer=newer
  mingw_ac_missing_list="${mingw_ac_missing_list}

To continue building ${PACKAGE_TARNAME}, you should install the following
or ${mingw_ac_newer} version${mingw_ac_missing_providers_plural} of:--
${mingw_ac_missing_providers}

and run configure again.
"; }
])# _MINGW_AC_SUGGEST_PROVIDERS

# $RCSfile$: end of file
