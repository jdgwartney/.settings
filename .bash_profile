#
# Bash Shell Settings
#

# Enable command line editing with VI
set -o vi

# Setting PATH for Python 2.7
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
export PATH

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
export ARCANIST_INSTALL=/Applications/arcanist/arcanist
export PATH=$PATH:$ARCANIST_INSTALL/bin

#
# Java configuration
#
#export JAVA_HOME=$(/usr/libexec/java_home)
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.7.0_51.jdk/Contents/Home
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_20-ea/Contents/Home

#
# EC2 Tools
#
export EC2_HOME=/usr/local/ec2/ec2-api-tools-1.6.12.2
export PATH=$PATH:$EC2_HOME/bin

[[ -s $HOME/.aws ]] && (source $HOME/.aws || echo "$HOME/.aws not found")

export EC2_URL=https://ec2.us-east-1.amazonaws.com

#
# CloudWatch Tools
#
export AWS_CLOUDWATCH_HOME=/usr/local/ec2/CloudWatch-1.0.20.0
export PATH=$PATH:$AWS_CLOUDWATCH_HOME/bin
export AWS_CLOUDWATCH_URL=http://monitoring.us-east-1.amazonaws.com/
export AWS_CREDENTIAL_FILE=$HOME/.cloudwatch-credentials

#
# Chef
#
CHEF_INSTALL=/opt/chef/embedded
export PATH=$CHEF_INSTALL/bin:$PATH

#
# Go language
#
export GOROOT=/usr/local/go
export PATH=$PATH:$GOROOT/bin

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
alias gitw="cd $GIT_WORKING"
alias gits="cd $GITS"
alias bc="cd $GITS/boundary-event-sdk"
alias bd="cd $GITS/boundary-service-database/db"
alias ba="cd $GITS/boundary-service-database/api"
alias bs="cd $GITS/camel-ping"
alias be="cd $GIT_WORKING/boundary-event-plugins"
alias om="cd $GIT_WORKING/swisscom/openstack-monitoring"
alias bshell="cd $GITS/boundary-api-shell"
alias swiss="cd $GIT_WORKING/swisscom"

alias eclipse="open /Applications/eclipse/Eclipse.app/"

export PATH=/usr/local/bin:$PATH


#
# Android SDK Setup
#
export ANDROID_SDK="/Users/davidg/Development/adt-bundle-mac-x86_64-20140321/sdk"

#
# Boundary API Shell
#
[[ -s "$HOME/.bshell/env.sh" ]] && source "$HOME/.bshell"

#
# Boundary API Configuration
#
[[ -s "$HOME/.boundary" ]] && source "$HOME/.boundary" 

#
# Boundary API Shell Configuration
#
[[ -s "$GITS/boundary-api-shell/env.sh" ]] && source "$GITS/boundary-api-shell/env.sh" 

#
# OpenStack Configuration
#
[[ -s "$HOME/.openstack" ]] && source "$HOME/.openstack" 

#
# GrapDat API Configuration
#
[[ -s "$HOME/.graphdat.conf" ]] && source "$HOME/.graphdat.conf" 

#
# SNMP4J SMI Configuration
#
[[ -s "$HOME/.snmp4j" ]] && source "$HOME/.snmp4j" 

#
# Ruby Version Manager
#
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

