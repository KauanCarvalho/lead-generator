# frozen_string_literal: true

module Lead
  module Generator
    class Twitter
      def initialize
        @items = %i[playstation5 xbox_one]
      end

      def perform
        @items.each do |item|
          twitter_api_result = ::Twitter::Api.search(item)

          Rails.logger.info("[#{self.class}] #{item} #{log_message(twitter_api_result)}")

          success = failed = 0

          twitter_api_result[:santos].to_a.each do |tweet|
            persist_tweet(tweet, 'Santos') ? success += 1 : failed += 1
          end

          Rails.logger.info("[#{self.class}] Santos, sucessos: #{success}, falhas: #{failed}")

          success = failed = 0

          twitter_api_result[:sp].to_a.each do |tweet|
            persist_tweet(tweet, 'Sao Paulo') ? success += 1 : failed += 1
          end

          Rails.logger.info("[#{self.class}] Sao Paulo, sucessos: #{success}, falhas: #{failed}")
        end
      end

      private

      def log_message(result)
        "Resultados para santos -> #{result[:santos].size}, para sp #{result[:sp].size}"
      end

      def persist_tweet(tweet, region)
        tweet_as_hash = tweet.to_h

        message   = tweet_as_hash.delete(:text)
        user_data = tweet_as_hash.delete(:user)

        lead = ::PublicationLead.new(provider: 'twitter', region:, message:, user_data:)

        lead.save
      end
    end
  end
end
