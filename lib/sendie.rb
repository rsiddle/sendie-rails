module Sendie
  autoload :Api, 'sendie/api'
  autoload :Config, 'sendie/config'
  autoload :VERSION, 'sendie/version'

  def self.included(base)
    base.class_eval do
      prepend InstanceMethods
      delegate :send_to, :substitute, :section, :subject, :substitute_subject,
               :uniq_args, :categories, :deliver_at, :template_id,
               to: :sendie_mailer
    end
  end

  module InstanceMethods
    def sendie_mailer
      @sendie_mailer ||= Sendie::Api.new
    end
  end

  class << self
    attr_writer :config

    def config
      @config ||= Sendie::Config.new
    end

    # Sendie.config will be default if block is not passed
    def configure
      yield(self.config) if block_given?
    end
  end
end
