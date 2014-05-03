#!/usr/bin/perl

# git remote add gerrit ssh://pcarenza@review.gerrithub.io:29418/TeamHorizon/android_packages_apps_Gallery2
# gitconfig
#[remote "gerrit"]
#        url = ssh://pcarenza@review.gerrithub.io:29418/TeamHorizon/android_build
#        fetch = +refs/heads/*:refs/remotes/gerrit/*
#        push = HEAD:refs/for/kitkat
#        receivepack = git receive-pack --reviewer jtoro2716@gmail.com --reviewer arhamjamal@gmail.com
#
# git config remote.gerrit.url "ssh://pcarenza@review.gerrithub.io:29418/TeamHorizon/android_build"
# git config remote.gerrit.push "HEAD:refs/for/kitkat"
# git config remote.gerrit.receivepack "git receive-pack --reviewer jtoro2716@gmail.com --reviewer arhamjamal@gmail.com"
# Fetch URL: https://github.com/TeamHorizon/platform_frameworks_base

@reviewers = ("jtoro271@gmail.com","arhamjamal@gmail.com","pcarenza@gmail.com");
chomp ($username = `whoami`);

chomp ($branch = `git branch| grep "*"`);
$branch =~ s/\*\s//g;

chomp ($repo = `git remote show th | grep "Fetch URL"`);
$repo =~ s/.*Fetch URL: https:\/\/github.com\/TeamHorizon\///g;

print "**** Setting up gerrit configuration for $repo. ****\n";

$basecommand = 'git config remote.gerrit.';

$base{'url'} = "ssh://$username\@gerrit.xenonhd.com:29418/$repo";

$base{'push'} = "HEAD:refs/for/kitkat";

$base{'receivepack'} = "git receive-pack";

$reviewertitle = "--reviewer ";

print "branch is $branch\n";
$addcommand = "git remote add gerrit $base{'url'}";
print "$addcommand\n";
`addcommand`;
$addcommand = 'gitdir=$(git rev-parse --git-dir); scp -p -P 29418 '.$username.'@gerrit.xenonhd.com:hooks/commit-msg ${gitdir}/hooks/';
print "$addcommand\n";
`addcommand`;

foreach my $key (keys %base) {
     $command= "$basecommand$key \"$base{$key}\"";
     print "$command\n";
     `$command`;     
}

