##
# ecutools: IoT Automotive Tuning, Diagnostics & Analytics
# Copyright (C) 2014 Jeremy Hahn
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

require_relative 'error'

def lib2534_so
  return @lib unless @lib.nil?
  if File.exist?('/usr/local/lib/libj2534.so')
    @lib = '/usr/local/lib/libj2534.so'
  elsif File.exist?('../.libs/libj2534.so')
    @lib = '../.libs/libj2534.so'
  elsif File.exist?('../../.libs/libj2534.so')
    @lib = '../../.libs/libj2534.so'
  end
  raise Ecutools::J2534Error, 'Unable to locate ecutools lib2534.so' unless @lib
  @lib
end

module Ecutools::J2534::Libj2534
  extend FFI::Library
  ffi_lib 'c'
  ffi_lib lib2534_so
  attach_function :PassThruScanForDevices, [ :pointer ], :long
  attach_function :PassThruGetNextDevice, [ :pointer ], :long
  attach_function :PassThruOpen, [ :pointer, :pointer ], :long
  attach_function :PassThruClose, [ :ulong ], :long
end
