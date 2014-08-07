#!/bin/sh

[install]

echo "Removing Oracle instant client..."

rm -rf #{dest_dir}

echo "Creating required directories for Oracle instant client..."

mkdir -p #{oracle_base}
mkdir -p #{tns_admin_dir}
mkdir -p #{dest_dir}

echo "Unzipping Oracle instant client..."

cp #{basic_zip} #{oracle_base}
cp #{sdk_zip} #{oracle_base}
cp #{sqlplus_zip} #{oracle_base}

unzip -o #{basic_zip} -d #{oracle_base}
unzip -o #{sdk_zip} -d #{oracle_base}
unzip -o #{sqlplus_zip} -d #{oracle_base}

echo "Creating soft links..."

ln -sF #{dest_dir}/libclntsh.dylib.11.1 #{dest_dir}/libclntsh.dylib


[install-ruby-oci8]

echo "Installing ruby-oci8 gem..."

ORACLE_BASE="#{oracle_base}"
DYLD_LIBRARY_PATH="#{dest_dir}"
TNS_ADMIN="#{tns_admin_dir}"
NLS_LANG='.UTF8'

ENV_VARS="ORACLE_BASE=$ORACLE_BASE DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH TNS_ADMIN=$TNS_ADMIN NLS_LANG=$NLS_LANG"

env $ENV_VARS bash -c 'gem install ruby-oci8 -v #{ruby_oci_version}'


[uninstall]

echo "Removing Oracle instant client..."

rm -rf #{dest_dir}

echo "Creating required directories for Oracle instant client..."

mkdir -p #{oracle_base}
mkdir -p #{tns_admin_dir}
mkdir -p #{dest_dir}

echo "Unzipping Oracle instant client..."

cp #{basic_zip} #{oracle_base}
cp #{sdk_zip} #{oracle_base}
cp #{sqlplus_zip} #{oracle_base}

unzip -o #{basic_zip} -d #{oracle_base}
unzip -o #{sdk_zip} -d #{oracle_base}
unzip -o #{sqlplus_zip} -d #{oracle_base}

echo "Creating soft links..."

ln -sF #{dest_dir}/libclntsh.dylib.11.1 #{dest_dir}/libclntsh.dylib


[verify]

echo "Testing Instant Client installation..."

RUBY="#{ruby_home}/bin/ruby"
ORACLE_BASE="#{oracle_base}"
DYLD_LIBRARY_PATH="#{dest_dir}"
TNS_ADMIN="#{tns_admin_dir}"
NLS_LANG='.UTF8'

ENV_VARS="ORACLE_BASE=$ORACLE_BASE DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH TNS_ADMIN=$TNS_ADMIN NLS_LANG=$NLS_LANG"

env $ENV_VARS $RUBY -e "#{cmd}"