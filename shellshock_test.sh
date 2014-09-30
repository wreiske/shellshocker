#!/bin/bash

# CVE-2014-6271
CVE20146271=$(env 'x=() { :;}; echo vulnerable' 'BASH_FUNC_x()=() { :;}; echo vulnerable' bash -c "echo test" 2>&1)

if [[ "$CVE20146271" =~ "vulnerable" ]]; then
	echo "CVE-2014-6271: VULNERABLE"
else
	echo "CVE-2014-6271: not vulnerable"
fi


# CVE-2014-7169
CVE20147169=$(cd /tmp 2>&1; rm -f /tmp/echo 2>&1; env 'x=() { (a)=>\' bash -c "echo uname" 2>&1; cat /tmp/echo 2>&1)

if [ -s /tmp/echo ]; then
	echo "CVE-2014-7169: VULNERABLE"
	rm -f /tmp/echo
else
	echo "CVE-2014-7169: not vulnerable"
fi


# CVE-2014-7186
CVE20147186=$(bash -c 'true <<EOF <<EOF <<EOF <<EOF <<EOF <<EOF <<EOF <<EOF <<EOF <<EOF <<EOF <<EOF <<EOF <<EOF' 2>/dev/null || echo "CVE-2014-7186 vulnerable, redir_stack")

if [[ "$CVE20147186" =~ "vulnerable" ]]; then
	echo "CVE-2014-7186: VULNERABLE"
else
	echo "CVE-2014-7186: not vulnerable"
fi


# CVE-2014-7187
CVE20147187=$((for x in {1..200}; do echo "for x$x in ; do :"; done; for x in {1..200}; do echo done; done) | bash || echo "CVE-2014-7187 vulnerable, word_lineno")

if [[ "$CVE20147187" =~ "vulnerable" ]]; then
	echo "CVE-2014-7186: VULNERABLE"
else
	echo "CVE-2014-7186: not vulnerable"
fi
