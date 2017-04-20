//verifying this is committed
use tweet;
sh.addShard("shard1/shard1_ip:shard1_port");
sh.addShard("shard1/shard2_ip:shard2_port");
sh.addShard("shard1/shard3_ip:shard3_port");
sh.addShard("shard1/shard4_ip:shard4_port");
sh.enableSharding("tweet");
sh.shardCollection("tweet.user", {"email": 1});
sh.shardCollection("tweet.tweets", {"username": 1})
sh.shardCollection("tweet.follows", {"follower_username": 1}); // potential problem b/c of query on username
sh.shardCollection("tweet.media", {"_id": 1})
sh.shardCollection("tweet.likes", {"uid": 1}) // problems!!!
sh.status();


/*
use tweet;
sh.addShard("shard1/192.168.1.45:27040");
sh.addShard("shard1/192.168.1.46:27040");
sh.addShard("shard1/192.168.1.47:27040");
sh.addShard("shard1/192.168.1.48:27040");
sh.enableSharding("tweet");
sh.shardCollection("tweet.user", {"email": 1});
sh.shardCollection("tweet.tweets", {"username": 1});
// potential problem b/c of query on username
sh.shardCollection("tweet.follows", {"follower_username": 1});
sh.shardCollection("tweet.media", {"_id": 1})
sh.shardCollection("tweet.likes", {"uid": 1})
sh.status();

*/