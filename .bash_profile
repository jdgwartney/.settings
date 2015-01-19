#
# Bash Shell Settings
#

# Enable command line editing with VI
set -o vi

# Setting PATH for Python 2.7
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
export PATH

export PYTHONPATH=/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/site-packages

export PATH=$PATH:/usr/local/sbin

#
# Ant
#
ANT_HOME=/Applications/apache-ant-1.9.4
PATH=$PATH:$ANT_HOME/bin

#
# Cassandra
#
CASSANDRA_INSTALL=/Applications/dsc-cassandra-2.0.11
export PATH=$PATH:$CASSANDRA_INSTALL/bin

#
# Maven configuration
#
export M2_HOME=/Applications/apache-maven-3.2.1
export PATH=$PATH:$M2_HOME/bin

function GenerateCamelComponent() {
  typeset -r groupId="$1"
  typeset -r artifactId="$2"
  typeset -r name="$3"
  typeset -r scheme="$4"
  typeset -r archetypeGroupId="org.apache.camel.archetypes"
  typeset -r archetypeArtifactId="camel-archetype-component"
  typeset -r archetypeVersion="2.13.1"

  if [ -z "${groupId}" -o -z "${artifactId}" -o -z "${name}" -o -z "${scheme}" ]
  then
    echo "usage: GenerateCamelComponent [groupId] [artifactId] [name] [scheme]" 
    return 1
  fi

mvn archetype:generate -DarchetypeGroupId="${archetypeGroupId}" -DarchetypeArtifactId="${archetypeArtifactId}" -DarchetypeVersion="${archetypeVersion}" -DgroupId="${groupId}" -DartifactId="${artifactId}" -Dname="${name}" -Dscheme="${scheme}"

   return $?
 }

#
# Arcanist configuration
#
export ARCANIST_INSTALL=$HOME/arcanist
export PATH=$PATH:$ARCANIST_INSTALL/bin

#
# Java configuration
#
#export JAVA_HOME=$(/usr/libexec/java_home)
#export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.7.0_51.jdk/Contents/Home
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.7.0_71.jdk/Contents/Home
#export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_20-ea/Contents/Home

#
# EC2 Tools
#
export EC2_HOME=/usr/local/ec2/ec2-api-tools-1.6.12.2
export PATH=$PATH:$EC2_HOME/bin

[[ -s $HOME/.ec2-credentials ]] && source $HOME/.ec2-credentials

#export EC2_URL=https://ec2.us-east-1.amazonaws.com

#
# CloudWatch Tools
#
export AWS_CLOUDWATCH_HOME=/usr/local/ec2/CloudWatch-1.0.20.0
export PATH=$PATH:$AWS_CLOUDWATCH_HOME/bin
export AWS_CLOUDWATCH_URL=http://monitoring.us-west-1.amazonaws.com/
export AWS_CREDENTIAL_FILE=$HOME/.cloudwatch-credentials

#
# RDS Tools
export AWS_RDS_HOME="/Applications/RDSCli-1.18.001"
export PATH=$PATH:$AWS_RDS_HOME/bin
export AWS_CREDENTIAL_FILE=$HOME/.rds-credentials
export EC2_REGION=us-west-1

#
# Chef
#
CHEF_INSTALL=/opt/chef/embedded
export PATH=$CHEF_INSTALL/bin:$PATH

#
# Go language
#
export GOROOT=/usr/local/go
export GOPATH=$HOME/gocode
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

LIQUIBASE_HOME=/Applications/liquibase
export PATH=$PATH:$LIQUIBASE_HOME
export PATH=$PATH:$LIQUIBASE_HOME/sdk


#
# MySQL
#

export MYSQL_HOME=/usr/local/mysql
export PATH=$PATH:$MYSQL_HOME/bin

#
# Mongo DB
#
export MONGO_DB_HOME="/Applications/mongodb-osx-x86_64-2.6.3"
export PATH="$PATH:$MONGO_DB_HOME/bin"

#
# Nagios plugins
#
export PATH="$PATH:/usr/local/nagios/libexec"


#
# Alias
#

#
# Shortcuts to GIT repositories
#
export GIT_WORKING=$HOME/git_working
export GITS=$HOME/git
export GGITS=$HOME/ggit
alias gitw="cd $GIT_WORKING"
alias gits="cd $GITS"
alias ggit="cd $GGITS"
alias ba="cd $GITS/boundary-service-database/api"
alias bc="cd $GITS/boundary-event-sdk"
alias bd="cd $GITS/boundary-service-database/db"
alias be="cd $GIT_WORKING/boundary-event-plugins"
alias bs="cd $GITS/camel-ping"
alias bpd="cd $GIT_WORKING/boundary-plugin-dev"
alias om="cd $GIT_WORKING/swisscom/openstack-monitoring"
alias centos="cd $GIT_WORKING/boundary-event-sdk-centos"
alias ubuntu="cd $GIT_WORKING/boundary-event-sdk-ubuntu"
alias bcli="cd $GITS/boundary-api-cli"
alias swiss="cd $GIT_WORKING/swisscom"
alias bvm="cd $GITS/boundary-vmware"
alias ipmi="cd $GITS/boundary-ipmi-integration"


alias jmx="cd $GITS/jmx-tutorial"

export SVN_WORKING=$HOME/svn_working
alias svnw="cd $SVN_WORKING"
alias bp="cd /Users/davidg/Documents/workspace/bsdk/boundary-nagios-plugins"
alias jmxa="cd $GITS/boundary-jmx-agent"
alias apip="cd $GITS/boundary-python-plugin-framework"

alias eclipse="open /Applications/eclipse/Eclipse.app/"
alias eclipse-luna="open /Applications/eclipse-luna/Eclipse.app/"
alias love="/Applications/love.app/Contents/MacOS/love" 
alias editmd="open -a /Applications/haroopad.app"

#
# Tomcat Server Configuration
#
TOMCAT_HOME=/Applications/apache-tomcat-7.0.53
TOMCAT_BIN="$TOMCAT_HOME/bin"
alias tomstartup="$TOMCAT_BIN/startup.sh"
alias tomshutdown="$TOMCAT_BIN/shutdown.sh"


export PATH=/usr/local/bin:$PATH

#
# Plugins
#
alias bps="cd $GITS/boundary-plugin-shell"
alias cas="cd $GITS/boundary-plugin-cassandra"
alias rabbitmq="cd $GITS/boundary-plugin-rabbitmq"
alias atc="cd $GITS/boundary-plugin-apache-tomcat"
alias jvm="cd $GITS/boundary-plugin-jvm"
alias postp="cd $GITS/boundary-plugin-postgresql"
alias ticker="cd $GITS/boundary-plugin-ticker"
alias redis="cd $GITS/boundary-plugin-redis"
alias aweb="cd $GITS/boundary-action-handler"
alias vmware="cd $GITS/boundary-plugin-vmware"
alias weather="cd $GITS/boundary-plugin-weather"
alias jpf="cd $GITS/boundary-plugin-framework-java"


[ -r "$HOME/git/boundary-python-plugin-framework/env.sh" ] && source "$HOME/git/boundary-python-plugin-framework/env.sh"
[ -r "$HOME/git/boundary-api-cli/env.sh" ] && source "$HOME/git/boundary-api-cli/env.sh"


#
# Android SDK Setup
#
export ANDROID_SDK="$HOME/adt-bundle-mac-x86_64-20140702"
export PATH="$PATH:$ANDROID_SDK/sdk/tools"
export PATH="$PATH:$ANDROID_SDK/sdk/platform-tools"
alias android-eclipse="open $ANDROID_SDK/eclipse/Eclipse.app/"

#
# Boundary API Shell
#
[[ -s "$HOME/.bshell/env.sh" ]] && source "$HOME/.bshell"

#
# Boundary API Configuration
#
[[ -s "$HOME/.boundary/config" ]] && source "$HOME/.boundary/config" 

#
# Boundary API Shell Configuration
#
[[ -s "$GITS/boundary-api-shell/env.sh" ]] && source "$GITS/boundary-api-shell/env.sh" 

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
# Faban
#
export FABAN_INSTALL=/Applications/faban
export PATH=$PATH:$FABAN_INSTALL/bin


#
# OpenStack Configuration
#
[[ -s "$HOME/.openstack" ]] && source "$HOME/.openstack" 

#
# GrapDat API Configuration
#
#[[ -s "$HOME/.graphdat.conf" ]] && source "$HOME/.graphdat.conf" 

#
# SNMP4J SMI Configuration
#
[[ -s "$HOME/.snmp4j" ]] && source "$HOME/.snmp4j" 

#
# Totango Configuration
#
[[ -s "$HOME/.totango" ]] && source "$HOME/.totango" 

#
# Ruby Version Manager
#
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

