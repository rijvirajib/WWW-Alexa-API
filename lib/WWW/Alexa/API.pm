package WWW::Alexa::API;

use strict;
use warnings FATAL => 'all';

use LWP::UserAgent;
use XML::Hash::LX;

our $VERSION = '0.03';

sub new {
  my $class = shift;
  my %vars = @_;
  my $self;

  $self->{ua} = LWP::UserAgent->new(agent => $vars{agent} || 'Opera 10.0') or return;
  $self->{ua}->proxy('http', $vars{proxy})                    if $vars{proxy};
  $self->{ua}->timeout($vars{timeout})                        if $vars{timeout};
  $self->{ua}->default_header('X-Real-IP', $vars{ip_address}) if $vars{ip_address};

  $self->{alexa} = ();

  bless ($self, $class);
}

sub get {
  my ($self, $domain_url) = @_;
  return unless defined $domain_url;

  my $res = $self->{ua}->get("http://xml.alexa.com/data?cli=10&dat=snbamz&url=$domain_url");
  return $res->status_line if !$res->is_success;

  my $res_hash = XML::Hash::LX::xml2hash($res->content);

  $self->{alexa} = \%{$res_hash->{ALEXA}} if \%{$res_hash->{ALEXA}};
  return \%{$self->{alexa}};
}

1;

=head1 NAME

WWW::Alexa::API - Query Alexa.com for Traffic information of website.

=head1 VERSION

Version 0.03

=head1 SYNOPSIS

use WWW::Alexa::API;

my $alexa = WWW::Alexa::API->new();
my $alexa_response = $alexa->get('example.com');

=head1 DESCRIPTION

The C<WWW::Alexa::API> is a class implementation interface for 
querying Alexa.com for Traffic information.

To use it, you should create a C<WWW::Alexa::API> object and 
use its method to get(), to query information for a domain.

=head1 CONSTRUCTOR METHOD

=over 4

=item $alexa = WWW::Alexa::API->new(%options);

This method constructs a new C<WWW::Alexa::API> object and returns it.
Key/value pair arguments can be provided to set up an initial user agent.
The following options allow specific attributes for C<LWP::UserAgent>

    KEY                     DEFAULT
    ------------            --------------------
    agent                   "Opera 10.0"
    proxy                   undef
    timeout                 undef
    ip_address              undef


C<agent> specifies the header 'User-Agent' when querying Alexa. If
the C<proxy> option is passed in, requests will be made through
specified poxy. C<proxy> is the host which serve requests to Alexa.
C<ip_address> allows you to set an X-Real-IP header for C<LWP::UserAgent>.

=back

=head1 QUERY METHOD

=over 4

=item $alexa_response->get('example.com');

Queries Alexa for a specified domain and return a hash reference.
If query fails for some reason (Alexa unreachable, undefined url passed)
a string or undefined.

=head1 AUTHOR

Rijvi Rajib, C<< <me at rij.co> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-www-alexa-api at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=WWW-Alexa-API>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc WWW::Alexa::API


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=WWW-Alexa-API>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/WWW-Alexa-API>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/WWW-Alexa-API>

=item * Search CPAN

L<http://search.cpan.org/dist/WWW-Alexa-API/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2013 Rijvi Rajib.

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

L<http://www.perlfoundation.org/artistic_license_2_0>

Any use, modification, and distribution of the Standard or Modified
Versions is governed by this Artistic License. By using, modifying or
distributing the Package, you accept this license. Do not use, modify,
or distribute the Package, if you do not accept this license.

If your Modified Version has been derived from a Modified Version made
by someone other than you, you are nevertheless required to ensure that
your Modified Version complies with the requirements of this license.

This license does not grant you the right to use any trademark, service
mark, tradename, or logo of the Copyright Holder.

This license includes the non-exclusive, worldwide, free-of-charge
patent license to make, have made, use, offer to sell, sell, import and
otherwise transfer the Package with respect to any patent claims
licensable by the Copyright Holder that are necessarily infringed by the
Package. If you institute patent litigation (including a cross-claim or
counterclaim) against any party alleging that the Package constitutes
direct or contributory patent infringement, then this Artistic License
to you shall terminate on the date that such litigation is filed.

Disclaimer of Warranty: THE PACKAGE IS PROVIDED BY THE COPYRIGHT HOLDER
AND CONTRIBUTORS "AS IS' AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES.
THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE, OR NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY
YOUR LOCAL LAW. UNLESS REQUIRED BY LAW, NO COPYRIGHT HOLDER OR
CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE OF THE PACKAGE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


=cut

1; # End of WWW::Alexa::API