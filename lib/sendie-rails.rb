require 'sendie'
require 'active_support'
require 'active_support/core_ext'
require 'action_mailer'

ActionMailer::Base.send :include, Sendie
