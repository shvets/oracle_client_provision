require File.expand_path('spec_helper', File.dirname(__FILE__))

require 'oracle_client_provision'

describe OracleClientProvision do
  subject { OracleClientProvision.new ".oracle_client_provision.json"}

  describe "#install" do
    it "calls install method" do
      subject.expects(:run).times(2)

      subject.install
    end
  end

end
