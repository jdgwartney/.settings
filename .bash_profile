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
alias ba="cd $GITS/boundary-service-database/api"
alias bc="cd $GITS/boundary-event-sdk"
alias bd="cd $GITS/boundary-service-database/db"
alias be="cd $GIT_WORKING/boundary-event-plugins"
alias bs="cd $GITS/camel-ping"
alias bpd="cd $GIT_WORKING/boundary-plugin-dev"
alias om="cd $GIT_WORKING/swisscom/openstack-monitoring"
alias centos="cd $GIT_WORKING/boundary-event-sdk-centos"
alias ubuntu="cd $GIT_WORKING/boundary-event-sdk-ubuntu"
alias bshell="cd $GITS/boundary-api-shell"
alias swiss="cd $GIT_WORKING/swisscom"

export SVN_WORKING=$HOME/svn_working
alias svnw="cd $SVN_WORKING"
alias bp="cd /Users/davidg/Documents/workspace/bsdk/boundary-nagios-plugins"
alias jmxa="cd $GITS/boundary-jmx-agent"
alias apip="cd $GITS/boundary-python-plugin-framework"

alias eclipse="open /Applications/eclipse/Eclipse.app/"
alias love="/Applications/love.app/Contents/MacOS/love" 

export PATH=/usr/local/bin:$PATH

#
# Plugins
#
alias bps="cd $GITS/boundary-plugin-shell"
alias rabbitmq="cd $GITS/boundary-plugin-rabbitmq"
# AWS Cloud Watch Plugins
alias aws-ec2="cd $GITS/boundary-plugin-aws-ec2"
alias aws-ebs="cd $GITS/boundary-plugin-aws-ebs"
alias aws-elb="cd $GITS/boundary-plugin-aws-elb"
alias aws-rds="cd $GITS/boundary-plugin-aws-rds"
alias aws-sqs="cd $GITS/boundary-plugin-aws-sqs"
alias postp="cd $GITS/boundary-plugin-postgresql"
alias ticker="cd $GITS/boundary-plugin-ticker"
alias redis="cd $GITS/boundary-plugin-redis"
alias aweb="cd $GITS/boundary-action-handler"


#
# Shows the current environment
#
bp-env() {
  echo "$BOUNDARY_PREMIUM_CURRENT_ACCOUNT"
  env | grep BOUNDARY_PREMIUM | sort
}

bp-acc() {
  ls -1 "$HOME/.boundary/accounts"
}

bp-set() {
  typeset config=$1
  BOUNDARY_PREMIUM_CURRENT_ACCOUNT="$config"

  # Create a menu if a configuration was not specified
  if [ -z "$config" ]
  then
    select opt in $(ls -1 $HOME/.boundary/accounts); do
      config="$opt"
      break
    done
  fi

  if [ -r "$HOME/.boundary/accounts/$config" ]
  then 
    source "$HOME/.boundary/accounts/$config"
  fi

  bp-env
}



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

