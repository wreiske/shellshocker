#!/bin/bash

# CVE-2014-6271
CVE20146271=$(env 'x=() { :;}; echo vulnerable' 'BASH_FUNC_x()=() { :;}; echo vulnerable' bash -c "echo test" 2>&1)

if [[ "$CVE20146271" =~ "vulnerable" ]]; then
	echo "CVE-2014-6271: VULNERABLE"
else
	echo "CVE-2014-6271: not vulnerable"
fi


# CVE-2014-7169
CVE20147169=$(env X=''() { (a)=>\'' bash -c "echo echo nonvuln" 2>/dev/null; [[ "$(cat echo 2> /dev/null)" == "nonvuln" ]] && echo "vulnerable" 2> /dev/null)

if [[ "$CVE20147169" =~ "vulnerable" ]]; then
	echo "CVE-2014-7169: VULNERABLE"
else
	echo "CVE-2014-7169: not vulnerable"
fi


# CVE-2014-7186
CVE20147186=$(bash -c 'true <<EOF <<EOF <<EOF <<EOF <<EOF <<EOF <<EOF <<EOF <<EOF <<EOF <<EOF <<EOF <<EOF <<EOF' 2>/dev/null || echo "vulnerable")

if [[ "$CVE20147186" =~ "vulnerable" ]]; then
	echo "CVE-2014-7186: VULNERABLE"
else
	echo "CVE-2014-7186: not vulnerable"
fi


# CVE-2014-7187
CVE20147187=$((for x in {1..200}; do echo "for x$x in ; do :"; done; for x in {1..200}; do echo done; done) | bash || echo "vulnerable")

if [[ "$CVE20147187" =~ "vulnerable" ]]; then
	echo "CVE-2014-7186: VULNERABLE"
else
	echo "CVE-2014-7186: not vulnerable"
fi
