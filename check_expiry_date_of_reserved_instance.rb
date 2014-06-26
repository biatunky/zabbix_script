#!/usr/bin/env ruby
# coding: utf-8

require 'aws-sdk'
require 'pp'

hostname = ARGV[0]

@ec2 = AWS::EC2.new()

AWS.memoize do

#引数のホスト名からインスタンスIDを取得
instanceid = @ec2.client.describe_tags(filters: [{ name: "value", values: [hostname] }])[:tag_set][0][:resource_id]

#インスタンスIDからリザーブドインスタンスIDを調べる
instances_information = @ec2.client.describe_instances(:instance_ids => [instanceid])
instance_tag = instances_information[:reservation_set][0][:instances_set][0][:tag_set]
instance_tag.each do |tag|
  @reservedid = tag[:value] if tag[:key] == "ReservedId"
end

#リザーブドインスタンスの有効期限の残り日数を計算
end_time = @ec2.client.describe_reserved_instances(options = {:reserved_instances_ids => [@reservedid]})[:reserved_instances_set][0][:end]
puts (end_time - Time.now).divmod(24*60*60)[0]

end
