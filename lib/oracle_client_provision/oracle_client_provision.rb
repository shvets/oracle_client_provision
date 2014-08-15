require 'script_executor/base_provision'

class OracleClientProvision < BaseProvision
  include Executable, ScriptLocator

  def initialize parent_class, config_file_name=".oracle_client_provision.json", scripts_file_names=[]
    scripts_file_names.unshift(File.expand_path("oracle_client_provision_scripts.sh", File.dirname(__FILE__))) # make it first

    super
  end

  def install
    puts "ruby home: #{env[:project][:ruby_home]}"
    puts "ruby_oci_version: #{env[:oracle][:ruby_oci_version]}"
    puts "user: #{env[:node][:user]}"

    run(server_info.merge({:sudo => true, :capture_output => true}), "install_client", env)

    run(server_info, "install-ruby-oci8", env)
  end

  def uninstall
    run({:sudo => true}, "uninstall", env)
  end

  def verify &code
    run(server_info, "verify_install", env.merge(:cmd => code.call))
  end

end
