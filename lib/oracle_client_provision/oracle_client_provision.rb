require 'json'
require 'script_executor/executable'
require 'script_executor/script_locator'
require 'script_executor/base_provision'
require 'text_interpolator'

class OracleClientProvision < BaseProvision
  include Executable, ScriptLocator

  def initialize parent_class, config_file_name=".oracle_client_provision.json", scripts_file_names=[]
    scripts_file_names.unshift(File.expand_path("oracle_client_provision_scripts.sh", File.dirname(__FILE__))) # make it first

    super
  end

  def install
    run(server_info.merge({:sudo => true, :capture_output => true}), "install", env)

    run(server_info, "install-ruby-oci8", env)
  end

  def uninstall
    run({:sudo => true}, "uninstall", env)
  end

  def verify &code
    run(server_info, "verify", env.merge(:cmd => code.call))
  end

end
