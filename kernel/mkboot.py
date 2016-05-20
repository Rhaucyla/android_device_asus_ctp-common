#!/usr/bin/env python

# mboot.py : script to unpack and re-pack boot.img for Android
# Copyright (c) 2014, Intel Corporation.
# Author: Falempe Jocelyn <jocelyn.falempe@intel.com>
# Author: Douglas Gadelha <douglas@gadeco.com.br>
#
# This program is free software; you can redistribute it and/or modify it
# under the terms and conditions of the GNU General Public License,
# version 2, as published by the Free Software Foundation.
#
# This program is distributed in the hope it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
# more details.

import os
import subprocess
from optparse import OptionParser
import struct
import re
import shutil

# call an external command
# optional parameter edir is the directory where it should be executed.
def call(cmd, edir=''):
    print '[', edir, '] Calling', cmd

    if edir:
        origdir = os.getcwd()
        os.chdir(os.path.abspath(edir))

    P = subprocess.Popen(args=cmd, stdout=subprocess.PIPE,
                         stderr=subprocess.PIPE, shell=True)

    if edir:
        os.chdir(origdir)

    stdout, stderr = P.communicate()
    if P.returncode:
        print cmd
        print "Failed " + stderr
        raise Exception('Error, stopping')
    return stdout

def write_file(fname, data, odir=True):
    if odir and options.dir:
        fname = os.path.join(options.dir, fname)
    print 'Write  ', fname
    out = open(fname, 'w')
    out.write(data)
    out.close()

def read_file(fname, odir=True):
    if odir and options.dir:
        fname = os.path.join(options.dir, fname)
    print 'Read   ', fname
    f = open(fname, 'r')
    data = f.read()
    f.close()
    return data

# Return next few bytes from file f
def check_byte(f, size):
    off = f.tell()
    byte = f.read(size)
    f.seek(-size, os.SEEK_CUR)
    return byte

def skip_pad(f, pgsz):
    npg = ((f.tell() / pgsz) + 1)
    f.seek(npg * pgsz)

def pack_ramdisk(dname):
    dname = os.path.join(options.dir, dname)
    print 'Packing directory [', dname, '] => ramdisk.cpio.gz'
    call('find . | cpio -o -H newc > ../ramdisk.cpio', dname)
    call('gzip -f ramdisk.cpio', options.dir)

def pack_bootimg_intel(fname):
    pack_ramdisk('root')
    kernel = read_file('kernel')
    ramdisk = read_file('ramdisk.cpio.gz')

    cmdline = read_file('cmdline').trim()
    cmdline_block = cmdline + (1024 - len(cmdline)) * '\0'
    cmdline_block += struct.pack('II', len(kernel), len(ramdisk))
    cmdline_block += read_file('parameter')
    cmdline_block += '\0' * (4096 - len(cmdline_block))

    sig = read_file('sig')

    data = cmdline_block
    data += read_file('bootstub')
    data += kernel
    data += ramdisk

    topad = 512 - (len(data) % 512)
    data += '\xFF' * topad

    # update signature
    n_block = (len(data) / 512)
    new_sig = sig[0:48] + struct.pack('I', n_block) + sig[52:]

    data = new_sig + data

    write_file(fname, data, odir=False)

def main():
    global options
    parser = OptionParser('null', version='%prog 0.1')
    parser.add_option("-d", "--directory", dest="dir", default='.', help="create boot.img from DIR")

    (options, args) = parser.parse_args()

    if len(args) != 1:
        parser.error("takes exactly 1 argument")

    bootimg = args[0]

    if options.dir and not os.path.isdir(options.dir):
        print 'error ', options.dir, 'is not a valid directory'
        return

    pack_bootimg_intel(bootimg)

if __name__ == "__main__":
    main()
