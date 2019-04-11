# frozen_string_literal: true

require 'openssl'
require 'spec_helper'

RSpec.describe Authentication::AuthnK8s::K8sObjectLookup do

  let(:webservice) { Authentication::Webservice.new(
    account: 'MockAccount',
    authenticator_name: 'authn-k8s',
    service_id: 'MockService'
  )}

  context "inside of kubernetes" do
    include_context "running in kubernetes"

    context "instantiation" do
      it "does not require a webservice" do
        expect { Authentication::AuthnK8s::K8sObjectLookup.new }.not_to raise_error
      end
    end

    subject { Authentication::AuthnK8s::K8sObjectLookup.new(webservice) }

    it "gets the correct api url" do
      expect(subject.api_url).to eq("https://#{kubernetes_api_url}:#{kubernetes_api_port}")
    end

    it "has the correct ssl options" do
      expect(subject.options[:ssl_options]).to include(:cert_store, :verify_ssl => OpenSSL::SSL::VERIFY_PEER)
    end

    it "has the correct auth options" do
      expect(subject.options[:auth_options]).to include(:bearer_token => kubernetes_service_token)
    end
  end

  context "outside of kubernetes" do
    include_context "running outside kubernetes"

    context "instantiation" do
      it "requires a webservice" do
        allow(Authentication::AuthnK8s::K8sContextValue).to receive(:get)
          .with(nil,
            Authentication::AuthnK8s::SERVICEACCOUNT_CA_PATH,
            Authentication::AuthnK8s::VARIABLE_CA_CERT)
          .and_return(nil)

        expect { Authentication::AuthnK8s::K8sObjectLookup.new }.to raise_error(Authentication::AuthnK8s::MissingCertificate)
      end
    end

    subject { Authentication::AuthnK8s::K8sObjectLookup.new(webservice) }

    it "gets the correct api url" do
      expect(subject.api_url).to eq(kubernetes_api_url)
    end

    it "has the correct ssl options" do
      expect(subject.options[:ssl_options]).to include(:cert_store, :verify_ssl => OpenSSL::SSL::VERIFY_PEER)
    end

    it "has the correct auth options" do
      expect(subject.options[:auth_options]).to include(:bearer_token => kubernetes_service_token)
    end
  end
end