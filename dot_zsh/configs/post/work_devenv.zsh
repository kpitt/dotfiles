# Set the default Java JDK (Zulu OpenJDK 11)
export JAVA_HOME=`/usr/libexec/java_home -v 11`

# Set up Perforce for command-line use.
export P4CONFIG=.p4config
export P4PORT=perforce.fortify.swinfra.net:1666

export SCA_MAKE_PARALLEL=4

export SWIFT_LIBRARIES=$HOME/.fortify/devtools/swift-libraries
