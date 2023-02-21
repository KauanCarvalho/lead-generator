# frozen_string_literal: true

module Twitter
  class Api
    class << self
      def search(item)
        query = case item
                when :playstation5
                  playstation5_query
                when :xbox_one
                  xbox_one_query
                else
                  item
                end

        complete_query = "#{query} #{basic_filters}"

        santos_results = client
                         .search(complete_query, geocode: santos_geocode, result_type: 'recent', lang: portuguese)
                         .take(limit)

        sp_results = client
                     .search(complete_query, geocode: sao_paulo_geocode, result_type: 'recent', lang: portuguese)
                     .take(limit)

        {
          santos: santos_results,
          sp: sp_results
        }
      end

      private

      def basic_filters
        'filter:safe -filter:retweets'
      end

      def playstation5_query
        'ps5 OR "playstation 5" OR playstation5 OR playstation OR #ps5 OR #playstation5 OR #playstation'
      end

      def xbox_one_query
        '"xbox one" OR xboxone OR xbox OR #xone OR #xboxone OR #xbox'
      end

      def sao_paulo_geocode
        '-23.533773,-46.625290,50km'
      end

      def santos_geocode
        '-23.9618,-46.3322,20km'
      end

      def portuguese
        'pt'
      end

      def limit
        10
      end

      def client
        @client ||= ::Twitter::REST::Client.new do |config|
          config.consumer_key    = 'ubQXVUjlWlMefczhN5UuGXa46'
          config.consumer_secret = 'CD9t7juKd47S07HsbPktTnHMK3NXC8Dp8J4eyzrHP3on2De2uX'
        end
      end
    end
  end
end
