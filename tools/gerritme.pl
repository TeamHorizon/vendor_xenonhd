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
# list default reviewers here
@reviewers = ('pcarenza@gmail.com','arhamjamal@gmail.com','jtoro2716@gmail.com');
# grabs user name from local unix system
chomp ($username = `whoami`);
# grabs active branch from 'git branch'
chomp ($branch = `git branch| grep "*"`);
$branch =~ s/\*\s//g;
# grab the repository name from the list of URLs
chomp ($repo = `git remote show th | grep "Fetch URL"`);
$repo =~ s/.*Fetch URL: https:\/\/github.com\/TeamHorizon\///g;

print "**** Setting up gerrit configuration for $repo. ****\n";

$basecommand = 'git config remote.gerrit.';

# the three config items that we're concerned about now
$base{'url'} = "ssh://$username\@gerrit.xenonhd.com:29418/$repo";
$base{'push'} = "HEAD:refs/for/kitkat";
$base{'receivepack'} = "git receive-pack";

# add reviewers to receivepack command
$reviewertitle = "--reviewer ";
foreach (@reviewers) {
    $base{'receivepack'} .= " $reviewertitle $_";
}
# add the gerrit remote 
print "branch is $branch\n";
$addcommand = "git remote add gerrit $base{'url'}";
print "$addcommand\n";
`addcommand`;
# add the commit message hook
$addcommand = 'gitdir=$(git rev-parse --git-dir); scp -p -P 29418 '.$username.'@gerrit.xenonhd.com:hooks/commit-msg ${gitdir}/hooks/';
print "$addcommand\n";
`addcommand`;
# finally, set the git config

foreach my $key (keys %base) {
     $command= "$basecommand$key \"$base{$key}\"";
     print "$command\n";
     `$command`;     
}

