#
# Bash Shell Settings
#

# Enable command line editing with VI
set -o vi

export PATH=$PATH:/usr/local/sbin

#
# Ant
#
ANT_HOME=/Applications/apache-ant-1.9.4
if [ -d "$ANT_HOME" ]
then
    PATH=$PATH:$ANT_HOME/bin
fi

#
# Cassandra
#
CASSANDRA_INSTALL=/Applications/dsc-cassandra-2.1.3
if [ -d "$CASSANDRA_INSTALL" ]
then
    export PATH=$PATH:$CASSANDRA_INSTALL/bin:$CASSANDRA_INSTALL/tools/bin
fi

#
# Maven configuration
#
MAVEN_VERSION=3.2.1
MAVEN_INSTALL=/Applications/apache-maven-${MAVEN_VERSION}
if [ -d "$MAVEN_INSTALL" ]
then
  export M2_HOME="$MAVEN_INSTALL"
  export PATH=$PATH:$M2_HOME/bin
fi

#
# Java configuration
#
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.7.0_80.jdk/Contents/Home
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_60.jdk/Contents/Home
if [ -d "$JAVA_HOME" ]
then
    export PATH=$JAVA_HOME/bin:$PATH
fi

#
# Go language
#

export GOROOT=/usr/local/go
export GOPATH=$HOME
export GOPATH=$HOME/gocode
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

#
# Gradle Configuration
#
export GRADLE_HOME="/Applications/gradle-2.3"
if [ -d "$GRADLE_HOME" ]
then
    export PATH=$PATH:$GRADLE_HOME/bin
fi

#
# Liquibase
#
LIQUIBASE_HOME=/Applications/liquibase
if [ -d "$LIQUIBASE_HOME" ]
then
    export PATH=$PATH:$LIQUIBASE_HOME
    export PATH=$PATH:$LIQUIBASE_HOME/sdk
fi

#
# MySQL
#

export MYSQL_HOME=/usr/local/mysql
if [ -d "$MYSQL_HOME" ]
then
    export PATH=$PATH:$MYSQL_HOME/bin
fi

#
# Mongo DB
#
export MONGO_DB_HOME="/Applications/mongodb-osx-x86_64-2.6.3"
if [ -d "$MONGO_DB_HOME" ]
then
    export PATH="$PATH:$MONGO_DB_HOME/bin"
fi

#
# Shortcuts to GIT repositories
#
export GITS=$HOME/git
alias gits="cd $GITS"


alias love="/Applications/love.app/Contents/MacOS/love" 
alias editmd="open -a /Applications/haroopad.app"
alias intellij="open -a '/Applications/IntelliJ IDEA 16.app'"
alias pycharm="open -a '/Applications/PyCharm.app'"

alias open-dir="open file://$(pwd)"

#
# Tomcat Server Configuration
#
TOMCAT_VERSION=/Applications/apache-tomcat-7.0.53
TOMCAT_HOME=/Applications/apache-tomcat-${TOMCAT_VERSION}
TOMCAT_BIN="$TOMCAT_HOME/bin"
alias tomstartup="$TOMCAT_BIN/startup.sh"
alias tomshutdown="$TOMCAT_BIN/shutdown.sh"


export PATH=/usr/local/bin:$PATH

#
# Import.io
#

IMPORT_IO_RC=$HOME/.import-io
[ -r "$IMPORT_IO_RC" ] && source "$IMPORT_IO_RC" 


IMPORT_IO_FUNC=$HOME/.import-io.sh
[ -r "$IMPORT_IO_FUNC" ] && source "$IMPORT_IO_FUNC" 

#
# Android SDK Setup
#
export ANDROID_SDK="$HOME/adt-bundle-mac-x86_64-20140702"
export PATH="$PATH:$ANDROID_SDK/sdk/tools"
export PATH="$PATH:$ANDROID_SDK/sdk/platform-tools"
alias android-eclipse="open $ANDROID_SDK/eclipse/Eclipse.app/"

#
# Matlab
#
alias matlab="/Applications/MATLAB_R2015a.app/bin/matlab -nodesktop"

#
# Boundary API Configuration
#
[[ -r "$HOME/.boundary/config" ]] && source "$HOME/.boundary/config" 

function path() {
  echo $PATH | tr : '\n' | awk '{ print $0}'
}

#
# Extract files
#
# unpack: Extract common file formats
function unpack() {
    if [[ -z "$@" ]]; then
        echo " ${0##*/} <archive> - extract common file formats)" exit
    fi
    # Required program(s)
    req_progs=(7z unrar unzip)
    req_progs=(unzip)
    for p in ${req_progs[@]}; do
        hash "$p" 2>&- || \
        { echo >&2 " Required program \"$p\" not installed."; return 1; }
    done

    # Test if file exists
    if [ ! -f "$@" ]; then
        echo "File "$@" doesn't exist" return
    fi

    # Extract file by using extension as reference
    case "$@" in
        *.7z ) 7z x "$@" ;;
        *.tar.bz2 ) tar xvjf "$@" ;;
        *.bz2 ) bunzip2 "$@" ;;
        *.deb ) ar vx "$@" ;;
        *.tar.gz ) tar xvf "$@" ;;
        *.gz ) gunzip "$@" ;;
        *.tar ) tar xvf "$@" ;;
        *.tbz2 ) tar xvjf "$@" ;;
        *.tar.xz ) tar xvf "$@" ;;
        *.tgz ) tar xvzf "$@" ;;
        *.rar ) unrar x "$@" ;;
        *.zip ) unzip "$@" ;;
        *.Z ) uncompress "$@" ;;
        * ) echo " Unsupported file format" ;;
    esac
}

#
# Data Integration
#

function spoon() {
 export PENTAHO_DI_JAVA_OPTIONS="-Xmx4096m -XX:MaxPermSize=4096m"
 pushd /Applications/data-integration > /dev/null 2>&1
 ./spoon.sh > /dev/null 2>&1 &
 popd > /dev/null 2>&1
}

#
# OpenStack Configuration
#
[[ -r "$HOME/.openstack" ]] && source "$HOME/.openstack" 


#
# SNMP4J SMI Configuration
#
[[ -r "$HOME/.snmp4j" ]] && source "$HOME/.snmp4j" 

#
# Totango Configuration
#
[[ -r "$HOME/.totango" ]] && source "$HOME/.totango" 

#
# Ruby Version Manager
#
[[ -r "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*



### Go Language
export GOPATH=$HOME/golang
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

#
# Help function that activates the python
# virtual environment in the current working
# directory
function pact() {
  typeset -r version=$1
  if [ "$version" == "2" ]
  then
    typeset -r python_dir="python"
  else
    typeset -r python_dir="python3"
  fi

  if [ -d "./$python_dir" ]
  then
    . $python_dir/bin/activate
  elif [ -d $HOME/$python_dir ] 
  then
    . $HOME/$python_dir/bin/activate
  else
    :
  fi

  return 0
}

py() {
    pact 2
}

py2() {
    pact 2
}

py3() {
    pact 3
}

#
# Setup TrueSight Pulse CLI environment variables
#
py 2>&1 > /dev/null
TSP_CLI_ENV=$(type -p tsp-cli-env.sh | cut -f3 -d ' ')
[ -r "$TSP_CLI_ENV" ] && source "$TSP_CLI_ENV"


# Setting PATH for Python 2.7
# The orginal version is saved in .bash_profile.pysave
#PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
#export PATH

# Setting PATH for Python 3.4
# The orginal version is saved in .bash_profile.pysave
#PATH="/Library/Frameworks/Python.framework/Versions/3.4/bin:${PATH}"
#export PATH

chef_installed=$(typeset chef)
if [ -n "$chef_installed" ]
then
  eval "$(chef shell-init bash)"
fi

# added by Anaconda3 2.3.0 installer
if [ -d /anaconda/bin ]
then
    export PATH="/anaconda/bin:$PATH"
fi

#
# Setup TrueSight Pulse CLI environment variables
#
py 2>&1 > /dev/null
TSP_CLI_ENV=$(type -p tsp-cli-env.sh | cut -f3 -d ' ')
[ -r "$TSP_CLI_ENV" ] && source "$TSP_CLI_ENV"


# Setting PATH for Python 2.7
# The orginal version is saved in .bash_profile.pysave
#PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
#export PATH

# Setting PATH for Python 3.4
# The orginal version is saved in .bash_profile.pysave
#PATH="/Library/Frameworks/Python.framework/Versions/3.4/bin:${PATH}"
#export PATH

chef_installed=$(typeset chef)
if [ -n "$chef_installed" ]
then
  eval "$(chef shell-init bash)"
fi

# added by Anaconda3 2.3.0 installer
if [ -d /anaconda/bin ]
then
    export PATH="/anaconda/bin:$PATH"
fi

