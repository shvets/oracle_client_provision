#!/bin/sh

[install_client]

echo "Removing Oracle instant client..."

rm -rf #{instant_client.dest_dir}

echo "Creating required directories for Oracle instant client..."

mkdir -p #{oracle.oracle_base}
mkdir -p #{oracle.tns_admin_dir}
mkdir -p #{instant_client.dest_dir}

echo "Unzipping Oracle instant client..."

cp #{instant_client.basic_zip} #{oracle.oracle_base}
cp #{instant_client.sdk_zip} #{oracle.oracle_base}
cp #{instant_client.sqlplus_zip} #{oracle.oracle_base}

unzip -o #{instant_client.basic_zip} -d #{oracle.oracle_base}
unzip -o #{instant_client.sdk_zip} -d #{oracle.oracle_base}
unzip -o #{instant_client.sqlplus_zip} -d #{oracle.oracle_base}

echo "Creating soft links..."

ln -sF #{instant_client.dest_dir}/libclntsh.dylib.11.1 #{instant_client.dest_dir}/libclntsh.dylib


[install-ruby-oci8]

echo "Installing ruby-oci8 gem..."

ORACLE_BASE="#{oracle.oracle_base}"
DYLD_LIBRARY_PATH="#{instant_client.dest_dir}"
TNS_ADMIN="#{oracle.tns_admin_dir}"
NLS_LANG=".UTF8"

ENV_VARS="ORACLE_BASE=$ORACLE_BASE DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH TNS_ADMIN=$TNS_ADMIN NLS_LANG=$NLS_LANG"

env $ENV_VARS bash -c 'gem install ruby-oci8 -v #{oracle.ruby_oci_version}'


[uninstall]

echo "Removing Oracle instant client..."

rm -rf #{instant_client.dest_dir}

echo "Creating required directories for Oracle instant client..."

mkdir -p #{oracle.oracle_base}
mkdir -p #{oracle.tns_admin_dir}
mkdir -p #{instant_client.dest_dir}

echo "Unzipping Oracle instant client..."

cp #{instant_client.basic_zip} #{oracle.oracle_base}
cp #{instant_client.sdk_zip} #{oracle.oracle_base}
cp #{instant_client.sqlplus_zip} #{oracle.oracle_base}

unzip -o #{instant_client.basic_zip} -d #{oracle.oracle_base}
unzip -o #{instant_client.sdk_zip} -d #{oracle.oracle_base}
unzip -o #{instant_client.sqlplus_zip} -d #{oracle.oracle_base}

echo "Creating soft links..."

ln -sF #{instant_client.dest_dir}/libclntsh.dylib.11.1 #{instant_client.dest_dir}/libclntsh.dylib


[verify_install]

echo "Testing Instant Client installation..."

RUBY="#{project.ruby_home}/bin/ruby"
ORACLE_BASE="#{oracle.oracle_base}"
DYLD_LIBRARY_PATH="#{instant_client.dest_dir}"
TNS_ADMIN="#{oracle.tns_admin_dir}"
NLS_LANG='.UTF8'

ENV_VARS="ORACLE_BASE=$ORACLE_BASE DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH TNS_ADMIN=$TNS_ADMIN NLS_LANG=$NLS_LANG"

env $ENV_VARS $RUBY -e "#{cmd}"