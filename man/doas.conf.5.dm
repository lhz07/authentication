Dd($Mdocdate: May 29 2026 $)
Dt(DOAS.CONF 5)
Os()

# NAME

Nm(doas.conf) Nd(doas configuration file)

# DESCRIPTION

The Xr(doas 1) utility executes commands as other users according to the rules in the Nm() configuration file.

The rules have the following format:

    (.Ic permit Ns | Ns Ic deny) Op:Ar(options) Ar(identity) [ Ic(as) Ar(target) ] [ Ic(cmd) Ar(command) [ Ic(args) [ Ar(argument ...) ] ] ]

Rules consist of the following parts:

(.Ic permit Ns | Ns Ic deny)
    The action to be taken if this rule matches.

Ar(options)
    Options are:

    Ic(nopass)
        The user is not required to enter a password.
    
    Ic(nolog)
        Do not log successful command execution to Xr(syslogd 8).

    Ic(persist) Op(Ic { Ar duration Ic })
        After the user successfully authenticates, do not ask for a password again for 5 minutes. br()
        The Ar(duration) may be specified as a number followed by Ic(m) for minutes or Ic(s) for seconds.
        For example, Ic(persist { 5m }) keeps the authentication valid for 5 minutes,
        while Ic(persist { 120s }) keeps it valid for 120 seconds.

    Ic(pwfeedback)
        Provide visual feedback while the user is entering a password.

    Ic(keepenv)
        Environment variables other than those listed in Xr(doas 1)
        are retained when creating the environment for the new process.

    Ic(setenv {) [ Ar(variable ...) ] [ Ar(variable=value ...) ] Ic(})
        Keep or set the space-separated specified variables.   
        Variables may also be removed with a leading Sq(-) or set using the latter syntax. 
        If the first character of Ar(value) is a Ql($) then the value to be set is taken from 
        the existing environment variable of the indicated name. 
        This option is processed after the default environment has been created.

Ar(identity)
    The username to match. 
    Groups may be specified by prepending a colon Pq:Sq(\&:).
    Numeric IDs are also accepted.

Ic(as) Ar(target)
    The target user the running user is allowed to run the command as. The default is all users.

Ic(cmd) Ar(command)
    The command the user is allowed or denied to run. The default is all commands. 
    Be advised that it is best to specify absolute paths. 
    If a relative path is specified, only a restricted Ev(PATH) will be searched.

Ic(args) [ Ar(argument ...) ]
    Arguments to command.
    The command arguments provided by the user need to match those specified.
    The keyword Ic(args) alone means that command must be run without any arguments.

The last matching rule determines the action taken. If no rule matches, the action is denied.
Comments can be put anywhere in the file using a hash mark Pq:Sq(#), and extend to the end of the current line.

The following quoting rules apply:
- The text between a pair of double quotes Pq:Sq(\&") is taken as is.
- The backslash character Pq:Sq(\e) escapes the next character, including new line characters, outside comments;
as a result, comments may not be extended over multiple lines.
- If quotes is used in a word, it is not considered a keyword.

# FILES

Bl(-tag -width /etc/examples/doas.conf -compact)
It:Pa(/etc/doas.conf)              Xr(doas 1) configuration file.
El()

# EXAMPLES

The following example permits user aja to install packages from a preferred mirror;
group wheel to execute commands as any user while keeping the environment
variables Ev(PS1) and Ev(SSH_AUTH_SOCK) and unsetting Ev(ENV);
permits tedu to run procmap as root without a password;
and additionally permits root to run unrestricted commands as itself
while retaining the original PATH.

Bd(-literal -offset indent)
permit persist setenv { PKG_CACHE PKG_PATH } aja cmd pkg_add
permit setenv { -ENV PS1=$DOAS_PS1 SSH_AUTH_SOCK } :wheel
permit nopass tedu as root cmd /usr/sbin/procmap
permit nopass keepenv setenv { PATH } root as root
Ed()

# SEE ALSO

Xr(doas 1), Xr(syslogd 8)

# HISTORY

The Nm() configuration file first appeared in Ox(5.8).

This enhanced configuration file was created in 2026.

# AUTHORS

An(Ted Unangst) Aq:Mt(tedu@openbsd.org)
	Author of the original Nm(doas) utility for Ox().

An(lhz07) Aq:Mt(lhz07c@gmail.com)
	Author of this enhanced Rust implementation.




