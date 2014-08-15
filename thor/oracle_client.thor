$: << File.expand_path(File.dirname(__FILE__) + '/../lib')

require 'oracle_client_provision'

class OracleClient < Thor
  @installer = OracleClientProvision.new self, ".oracle_client_provision.json"

  class << self
    attr_reader :installer
  end

  desc "install", "Installs Oracle Instant Client"
  def install
    OracleClient.installer.install
  end

  desc "uninstall", "Uninstalls Oracle Instant Client"
  def uninstall
    OracleClient.installer.uninstall
  end

  desc "verify", "Verifies Oracle Instant Client connection"
  def verify
    username = "scott"
    password = "tiger"
    schema   = "ORCL"
    sql      = "SELECT * FROM emp where rownum <= 10"

    OracleClient.installer.verify do
      "require 'oci8'; OCI8.new('#{username}','#{password}','#{schema}').exec('#{sql}') do |r| puts r.join(','); end"
    end
  end

end

