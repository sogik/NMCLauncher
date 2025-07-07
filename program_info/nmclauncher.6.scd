nmclauncher(6)

# NAME

nmclauncher - a launcher and instance manager for Minecraft.

# SYNOPSIS

_nmclauncher_ [OPTIONS...]

# DESCRIPTION

NMC Launcher is a custom launcher for Minecraft that allows you to easily manage
multiple installations of Minecraft at once. It also allows you to easily
install and remove mods by simply dragging and dropping.
Here are the current features of NMC Launcher.

# OPTIONS

_-d, --dir_=DIRECTORY
Use DIRECTORY as the NMC Launcher root.

_-l, --launch_=INSTANCE_ID
Launch the instance specified by INSTANCE_ID.

_--show_=INSTANCE_ID
Show the configuration window of the instance specified by INSTANCE_ID.

_--alive_
Write a small 'live.check' file after NMC Launcher starts.

_-h, --help_
Display help text and exit.

_-v, --version_
Display program version and exit.

_-a, --profile_=PROFILE
Use the account specified by PROFILE (only valid in combination with --launch).

# ENVIRONMENT

The behavior of the launcher can be customized by the following environment
variables, besides other common Qt variables:

_QT_LOGGING_RULES_
Specifies which logging categories are shown in the logs. One can
enable/disable multiple categories by separating them with a semicolon (;).

    The specific syntax, and alternatives to this setting, can be found at
    https://doc.qt.io/qt-6/qloggingcategory.html#configuring-categories.

_QT_MESSAGE_PATTERN_
Specifies the format in which the console output will be shown.

    Available options, as well as syntax, can be viewed at
    https://doc.qt.io/qt-6/qtglobal.html#qSetMessagePattern.

# EXIT STATUS

_0_
Success

_1_
Failure (syntax or usage error; configuration error; unexpected error).

# BUGS

https://github.com/sogik/NMCLauncher/issues

# RESOURCES

GitHub: https://github.com/sogik/NMCLauncher

# AUTHORS

sogik

Prism Launcher Contributors

PollyMC Contributors
