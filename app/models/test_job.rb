# frozen_string_literal: true

class TestJob
  include SuckerPunch::Job

  def perform
    puts 'jiihaa'

    Rails.cache.write('beer top 3', Beer.top(3))
    Rails.cache.write('brewery top 3', Brewery.top(3))
    Rails.cache.write('style top 3', Style.top(3))

    TestJob.perform_in(600.seconds)
  end
end
