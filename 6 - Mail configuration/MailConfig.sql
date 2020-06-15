-- Mail configuration
sp_CONFIGURE 'show advanced', 1
GO
RECONFIGURE
GO
sp_CONFIGURE 'Database Mail XPs', 1
GO
RECONFIGURE
GO

-- Create mail account
-- /!\/!\/!\ Update password before launch /!\/!\/!\
EXECUTE msdb.dbo.sysmail_add_account_sp
    @account_name = 'Ulala Admin',
    @description = 'Sent Mail',
    @email_address = 'adm.ulalastrat@gmail.com',
    @display_name = 'UlalaStrat Admin',
    @username='adm.ulalastrat@gmail.com',
    @password='********',
    @mailserver_name = 'smtp.gmail.com',
    @port = 587,
    @enable_ssl = 1;

-- Create a Database Mail profile  
EXECUTE msdb.dbo.sysmail_add_profile_sp  
    @profile_name = 'UlalaStrat Admin Profile',  
    @description = 'Profile used for administrative mail.' ;  
  
-- Add the account to the profile  
EXECUTE msdb.dbo.sysmail_add_profileaccount_sp  
    @profile_name = 'UlalaStrat Admin Profile',  
    @account_name = 'Ulala Admin',  
    @sequence_number = 1;  
  
-- Grant access to the profile to the DBMailUsers role  
EXECUTE msdb.dbo.sysmail_add_principalprofile_sp  
    @profile_name = 'UlalaStrat Admin Profile',  
    @principal_name = 'public',  
    @is_default = 1;