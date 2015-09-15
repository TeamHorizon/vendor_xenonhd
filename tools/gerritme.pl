#!/usr/bin/perl
# gerritme.pl
#
#/*
# * Copyright (C) 2015 Team Horizon
# *
# * Licensed under the Apache License, Version 2.0 (the "License");
# * you may not use this file except in compliance with the License.
# * You may obtain a copy of the License at
# *
# *      http://www.apache.org/licenses/LICENSE-2.0
# *
# * Unless required by applicable law or agreed to in writing, software
# * distributed under the License is distributed on an "AS IS" BASIS,
# * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# * See the License for the specific language governing permissions and
# * limitations under the License.
# */
#

# softcoded config
@reviewers = ('pcarenza@gmail.com','jtoro2716@gmail.com','arhamjamal@gmail.com');
$gerrithost = "83.233.5.249";
$defaultbranch = "lp-mr1";
$mainremote = "th";
$gitname= "TeamHorizon";

# grabs user name from local unix system
chomp ($username = `git config user.name`);
if ($username eq "") {
	chomp($username = `whoami`);
}

# grab the repository name from the list of URLs
if (`git remote show | grep $mainremote`) {
    print "found $mainremote remote...\n";
    chomp ($repo = `git remote show $mainremote | grep "Fetch URL"`);
} elsif (`git remote show | grep gh`) {
    print "found gh remote...\n";
    chomp ($repo = `git remote show gh | grep "Fetch URL"`);
} else {
    chomp($findone = `git remote -v | grep $gitname | grep fetch | grep -v gerrit | grep -v gforce | cut -f1`); 
    if ($findone) {
        print "Found another gh remote... $findone\n";
	chomp($repo = `git remote -v | grep $findone | grep fetch | cut -f2`);
    } else {
        print "cannot find $gitname remote. Exiting... \n";
        exit(0);
    }
}
$repo =~ s/.*Fetch URL: //g;
$repo =~ s/https:\/\/github.com\///g;

print "**** Setting up gerrit configuration for $repo. ****\n";

# grabs active branch from 'git rev-parse'
if ($ARGV[0]) {
        $branch = $ARGV[0];
} else {
        @branch = `git rev-parse --symbolic-full-name --abbrev-ref --remotes`;
	if ($findone) {
            @branchz = grep (/^(th|gh|$findone)/, @branch);
        } else {
            @branchz = grep (/^(th|gh)/, @branch);
        }
        chomp ($branch = $branchz[0]);
        $branch =~ s/^.*\///g;
        
}

# sets up the base git config command
$basecommand = 'git config remote.gerrit.';
$forcecommand = 'git config remote.gforce.';

# add reviewers to receivepack command
$reviewertitle = "--reviewer ";
foreach (@reviewers) {
    $base{'receivepack'} .= " $reviewertitle $_";
}

# add the gerrit remote branch
if ($branch eq '') {
	print "branch was unknown, it is now $defaultbranch\n";
	$branch = "$defaultbranch";
} else {
print "branch is $branch\n";
}

# the three config items that we're concerned about now
$base{'url'} = "ssh://$username\@$gerrithost:29418/$repo";
$base{'push'} = "HEAD:refs/for/$branch";
$base{'receivepack'} = "git receive-pack $base{'receivepack'}";

$force{'url'} = "ssh://$username\@$gerrithost:29418/$repo";
$force{'push'} = "HEAD:refs/heads/$branch";
$force{'receivepack'} = "git receive-pack";


# add the commit message hook
$revparse = `git rev-parse --git-dir`;
chomp $revparse;
#print "$revparse\n";


 $addcommand = 'scp -p -P 29418 '.$username.'@'.$gerrithost.':hooks/commit-msg '.$revparse.'/hooks/commit-msg';
print "$addcommand\n";
`$addcommand`;


# finally, set the git config
foreach my $key (keys %base) {
     $command= "$basecommand$key \"$base{$key}\"";
     print "$command\n";
     `$command`;
}
foreach my $key (keys %force) {
    $command = "$forcecommand$key \"$force{$key}\"";
    print "$command\n";
    `$command`;
}

