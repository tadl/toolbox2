desc "Remove trailers that are no longer on youtube or embedable"
task :remove_bad_trailers => :environment do
    trailers = Trailer.all.where.not(youtube_url: nil)
    good_trailer_count = 0
    bad_trailer_count = 0
    trailers.each do |t|
        is_good = t.just_check_youtube
        if is_good == true
            puts t.title + ' was good.'
            good_trailer_count += 1
        else
            puts t.title + ' was BAD.'
            bad_trailer_count += 1
            t.youtube_url = nil
            t.save
        end
    end
    puts 'Valid trailers: ' + good_trailer_count.to_s
    puts 'Bad trailers: ' + bad_trailer_count.to_s

end