#!/bin/bash

# CVE-2014-6271
CVE20146271=$(env 'x=() { :;}; echo vulnerable' 'BASH_FUNC_x()=() { :;}; echo vulnerable' bash -c "echo test" 2>&1 | grep 'vulnerable' | wc -l)

echo -n "CVE-2014-6271 (original shellshock): "
if [ $CVE20146271 -gt 0 ]; then
	echo -e "\033[91mVULNERABLE\033[39m"
else
	echo -e "\033[92mnot vulnerable\033[39m"
fi

# CVE-2014-7169
CVE20147169=$((cd /tmp; rm -f /tmp/echo; env X='() { (a)=>\' bash -c "echo echo nonvuln" 2>/dev/null; [[ "$(cat echo 2> /dev/null)" == "nonvuln" ]] && echo "vulnerable" 2> /dev/null) | grep 'vulnerable' | wc -l)

echo -n "CVE-2014-7169 (taviso bug): "
if [ $CVE20147169 -gt 0 ]; then
	echo -e "\033[91mVULNERABLE\033[39m"
else
	echo -e "\033[92mnot vulnerable\033[39m"
fi

# CVE-2014-////
CVE2014=$(env X=' () { }; echo hello' bash -c 'date' | grep 'hello' | wc -l)

echo -n "CVE-2014-//// (exploit 3 on http://shellshocker.net/): "
if [ $CVE2014 -gt 0 ]; then
	echo -e "\033[91mVULNERABLE\033[39m"
else
	echo -e "\033[92mnot vulnerable\033[39m"
fi

# CVE-2014-7186
CVE20147186=$((bash -c 'true <<EOF <<EOF <<EOF <<EOF <<EOF <<EOF <<EOF <<EOF <<EOF <<EOF <<EOF <<EOF <<EOF <<EOF' 2>/dev/null || echo "vulnerable") | grep 'vulnerable' | wc -l)

echo -n "CVE-2014-7186 (redir_stack bug): "
if [ $CVE20147186 -gt 0 ]; then
	echo -e "\033[91mVULNERABLE\033[39m"
else
	echo -e "\033[92mnot vulnerable\033[39m"
fi

# CVE-2014-7187
CVE20147187=$(((for x in {1..200}; do echo "for x$x in ; do :"; done; for x in {1..200}; do echo done; done) | bash || echo "vulnerable") | grep 'vulnerable' | wc -l)

echo -n "CVE-2014-7187 (nested loops off by one): "
if [ $CVE20147187 -gt 0 ]; then
	echo -e "\033[91mVULNERABLE\033[39m"
else
	echo -e "\033[92mnot vulnerable\033[39m"
fi

# CVE-2014-6278
CVE20146278=$(shellshocker='() { echo vulnerable; }' bash -c shellshocker | grep 'vulnerable' | wc -l)

echo -n "CVE-2014-6278 (Florian's patch): "
if [ $CVE20146278 -gt 0 ]; then
	echo -e "\033[91mVULNERABLE\033[39m"
else
	echo -e "\033[92mnot vulnerable\033[39m"
fi