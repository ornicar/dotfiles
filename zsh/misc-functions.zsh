#!/bin/zsh

# Get a 7 chars password: generate-password 7
generate-password() {
  strings /dev/urandom | grep -o '[[:alnum:]]' | head -n $1 | tr -d '\n'; echo
}

# Man inside vim
man() { vim -M -c "Man $*" -c "set nomodifiable" -c "only" }

# Calculator
calc() { awk "BEGIN{ print $* }" ;}

psg() { ps aux | grep $* }

# java8() {
#   export PATH="/usr/lib/jvm/java-8-openjdk/jre/bin/:$PATH"
#   java -version
# }
# java9() {
#   export PATH="/usr/lib/jvm/java-9-jdk/jre/bin/:$PATH"
#   java -version
# }
java11() {
  export PATH="/usr/lib/jvm/java-11-openjdk/bin/:$PATH"
  java -version
}
# java13() {
#   export PATH="/usr/lib/jvm/java-13-openjdk/bin/:$PATH"
#   java -version
# }
grallvm11() {
  export PATH="/usr/lib/jvm/java-11-grallvm/bin/:$PATH"
  java -version
}
