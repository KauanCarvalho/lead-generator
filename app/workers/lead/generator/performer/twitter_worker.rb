# frozen_string_literal: true

module Lead
  module Generator
    module Performer
      class TwitterWorker
        include Sidekiq::Worker

        def perform(*_args)
          Lead::Generator::Twitter.new.perform
        end
      end
    end
  end
end
