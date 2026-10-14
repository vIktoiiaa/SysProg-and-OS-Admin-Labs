Name:           count-files
Version:        2.0
Release:        1%{?dist}
Summary:        Script to count regular files in /etc

License:        MIT
URL:            https://github.com/vIktoiiaa/SysProg-and-OS-Admin-Labs
Source0:        %{name}-%{version}.tar.gz
BuildArch:      noarch
Requires:       bash
Requires:       coreutils
Requires:       findutils

%description
A Bash script that counts the number of regular files
in the /etc directory, excluding directories and symbolic links.

%prep
%setup -q

%pre
echo "Installing count-files package..."

%install
mkdir -p %{buildroot}%{_bindir}
mkdir -p %{buildroot}%{_mandir}/man1
mkdir -p %{buildroot}%{_sysconfdir}

install -m 755 count_files.sh %{buildroot}%{_bindir}/count_files
install -m 644 count_files.1 %{buildroot}%{_mandir}/man1/count_files.1
install -m 644 count_files.conf %{buildroot}%{_sysconfdir}/count_files.conf

%post
chmod +x %{_bindir}/count_files
echo "Package count-files installed successfully!"
echo "Script location: %{_bindir}/count_files"

%files
%{_bindir}/count_files
%{_mandir}/man1/count_files.1*
%config(noreplace) %{_sysconfdir}/count_files.conf

%changelog
* Wed Oct 14 2026 Viktoriia Koshman <kosmanvika22@gmail.com> - 2.0-1
- Added man page, config file, %pre/%post scripts
- Updated to version 2.0

* Wed Oct 14 2026 Viktoriia Koshman <kosmanvika22@gmail.com> - 1.0-1
- Initial package release
