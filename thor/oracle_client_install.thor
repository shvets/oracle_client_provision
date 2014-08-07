$: << File.expand_path(File.dirname(__FILE__) + '/../lib')

require 'oracle_client_provision'

class OracleClientInstall < Thor
  @installer = OracleClientProvision.new self, ".oracle_client_provision.json"

  class << self
    attr_reader :installer

    puts "ruby home: #{installer.env[:ruby_home]}"
    puts "ruby_oci_version: #{installer.env[:ruby_oci_version]}"
    puts "user: #{installer.env[:user]}"
  end

  desc "install", "Installs Oracle Instant Client"
  def install
    OracleClientInstall.installer..install
  end

  desc "uninstall", "Uninstalls Oracle Instant Client"
  def uninstall
    OracleClientInstall.installer.uninstall
  end

  desc "verify", "Verifies Oracle Instant Client connection"
  def verify
    username = "scott"
    password = "tiger"
    schema   = "ORCL"
    sql      = "SELECT * FROM emp where rownum <= 10"

    OracleClientInstall.installer.verify do
      "require 'oci8'; OCI8.new('#{username}','#{password}','#{schema}').exec('#{sql}') do |r| puts r.join(','); end"
    end
  end

end

