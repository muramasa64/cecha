require 'aws-sdk'
require 'openssl'

module Cecha
  class Client
    attr_reader :logger

    ElbCert = Struct.new("ElbCert", :elb_name, :elb_port, :ssl_certificate_name, :signature_algorithm) do
      def to_s
        values.join("\t")
      end
    end

    def initialize(cli_options = {}, aws_configuration = {})
      @cli_options = cli_options
      @logger ||= Logger.new STDOUT

      aws_configuration[:logger] = Logger.new STDOUT if @cli_options[:verbose]

      @elasticloadbalancing = Aws::ElasticLoadBalancing::Resource.new aws_configuration
      @iam = Aws::IAM::Resource.new aws_configuration
    end

    def list
      certlist = []
      begin
        resp = @elasticloadbalancing.client.describe_load_balancers
        resp.load_balancer_descriptions.each do |elb|
          elb.listener_descriptions.each do |desc|
            cert = ssl_certificate(desc.listener.ssl_certificate_id)
            if cert
              elbcert = ElbCert.new(elb.load_balancer_name)
              elbcert.elb_port = desc.listener.load_balancer_port
              elbcert.ssl_certificate_name = cert.name
              elbcert.signature_algorithm = OpenSSL::X509::Certificate.new(cert.certificate_body).signature_algorithm
              certlist << elbcert
            end
          end
        end
      rescue Aws::ElasticLoadBalancing::Errors::ServiceError => e
        @logger.err e
      end
      certlist
    end

    private
    def ssl_certificate(arn)
      @iam.server_certificates.find do |cert|
        cert.server_certificate_metadata.arn == arn
      end
    end
  end
end
