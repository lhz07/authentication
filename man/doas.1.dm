Dd($Mdocdate: May 28 2026 $)
Dt(DOAS 1)
Os()

# NAME

Nm(doas) Nd(execute commands as another user)

# SYNOPSIS

Nm(doas) Op:Fl(Lns) Op:Fl(Cv Ar config) Op:Fl(u Ar user) Ar(command) Op:Ar(args ...)
Nm(doas) Op:Nm(vidoas)
Nm(doas) Op:Fl(-version)

# DESCRIPTION

The Nm(doas) utility executes the given command as another user. The Ar(command) argument is mandatory unless Fl(C), Fl(L), or Fl(s) is specified.

The user will be required to authenticate by entering their password, unless configured otherwise.

By default, a new environment is created. The variables Ev(HOME), Ev(LOGNAME), Ev(PATH), Ev(SHELL), and Ev(USER) are set to values appropriate for the target user. Ev(DOAS_USER) is set to the name of the user executing Nm(doas). The variables Ev(DISPLAY) and Ev(TERM) are inherited from the current environment. br()
This behavior may be modified by the config file. The working directory is not changed.

# SUBCOMMANDS

Cm(vidoas)
	Safely edit and check the doas.conf configuration file.

# OPTIONS

Fl(-version)
	Print version information and exit.

Fl(L)
	Clear any persisted authentications from previous invocations, then immediately exit. br()
	No command is executed.

Fl(n)
	Non interactive mode, fail if the matching rule doesn't have the Ic(nopass) option.

Fl(s)
	Execute the shell from Ev(SHELL) or Pa(/etc/passwd).

Fl(u) Ar(user)
	Execute the command as Ar(user). The default is root.

Fl(C) Op:Fl(v) Ar(config)
    Parse and check the configuration file Ar(config), then exit.

    If the Fl(v) option is specified alongside Fl(C), verbose output will be enabled, printing the fully parsed configuration details to standard output.
	
	If Ar(command) is supplied, Nm(doas) will also perform command matching. 
    In the latter case either Sq(permit), Sq(permit nopass) or Sq(deny) will be printed on standard output, depending on command matching results. br()
    No command is executed.

# EXIT STATUS

Ex(-std doas) br()
It may fail for one of the following reasons:

- The config file Pa(/etc/doas.conf) could not be parsed.
- The user attempted to run a command which is not permitted.
- The password was incorrect.
- The specified command was not found or is not executable.

# SEE ALSO

Xr(su 1), Xr(doas.conf 5)

# HISTORY

The original Nm(doas) command first appeared in Ox(5.8).

This enhanced implementation was created in 2026.

# AUTHORS

An(Ted Unangst) Aq:Mt(tedu@openbsd.org)
	Author of the original Nm(doas) utility for Ox().

An(lhz07) Aq:Mt(lhz07c@gmail.com)
	Author of this enhanced Rust implementation.

