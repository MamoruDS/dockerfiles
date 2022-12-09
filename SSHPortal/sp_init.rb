#!/bin/ruby
# frozen_string_literal: true

`addgroup -g 4096 yourgrp`

Dir.entries('/home').select { |f| File.directory? File.join('/home', f) }.each do |user|
    next if user.start_with?('.')

    stat = File.stat(File.join('/home', user))
    uid = stat.uid
    gid = stat.gid

    `adduser -h /home/#{user} -s /bin/ash -u #{uid} -G pangu -D #{user}`
    if $?.exitstatus.zero?
        puts "create user: #{user}(#{uid}):#{gid}"
        if File.exist?(File.join('/home', user, '.ssh', 'authorized_keys'))
            # using non-empty(random) password for allowing ssh login
            password = (0...8).map { rand(65..90).chr }.join
            `echo "#{user}:#{password}" | chpasswd`
        else
            `echo "#{user}:localpasswd" | chpasswd`
            puts "set password for #{user}"
        end
    else
        puts "skip #{user}"
    end
end
