﻿// ------------------------------------------------------------------------------
//  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
// ------------------------------------------------------------------------------
namespace Microsoft.Graph.PowerShell.Authentication.Cmdlets
{
    using Microsoft.Graph.Auth;
    using Microsoft.Graph.PowerShell.Authentication.Helpers;
    using Microsoft.Graph.PowerShell.Authentication.Models;
    using System;
    using System.Collections.Generic;
    using System.IO;
    using System.Management.Automation;
    using System.Net.Http;
    using System.Threading;
    using System.Threading.Tasks;

    [Cmdlet(VerbsCommunications.Connect, "Graph", DefaultParameterSetName = Constants.UserParameterSet)]
    public class ConnectGraph : PSCmdlet
    {

        [Parameter(ParameterSetName = Constants.UserParameterSet, Position = 1)]
        public string[] Scopes { get; set; }

        [Parameter(ParameterSetName = Constants.AppParameterSet, Position = 1, Mandatory = true)]
        public string ClientId { get; set; }

        [Parameter(ParameterSetName = Constants.AppParameterSet, Position = 2)]
        public string CertificateName { get; set; }

        [Parameter(Position = 3)]
        public string TenantId { get; set; }

        [Parameter(Position = 4)]
        public SwitchParameter ForceRefresh { get; set; }

        private static readonly string InstallationPath = Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().Location);

        protected override void BeginProcessing()
        {
            validateParameters();
            base.BeginProcessing();
        }

        protected override void EndProcessing()
        {
            base.EndProcessing();
        }

        protected override void ProcessRecord()
        {
            base.ProcessRecord();

            AuthConfig authConfig = new AuthConfig { TenantId = TenantId };
            CancellationToken cancellationToken = CancellationToken.None;

            if (ParameterSetName == Constants.UserParameterSet)
            {
                // 2 mins timeout. 1 min < HTTP timeout.
                TimeSpan authTimeout = new TimeSpan(0, 0, Constants.MaxDeviceCodeTimeOut);
                CancellationTokenSource cts = new CancellationTokenSource(authTimeout);
                cancellationToken = cts.Token;

                authConfig.AuthType = AuthenticationType.Delegated;
                authConfig.Scopes = Scopes ?? new string[] { "User.Read" };
            }
            else
            {
                authConfig.AuthType = AuthenticationType.AppOnly;
                authConfig.ClientId = ClientId;
                authConfig.CertificateName = CertificateName;
            }

            // Save auth config to session state.
            SessionState.PSVariable.Set(Constants.GraphAuthConfigId, authConfig);

            try
            {
                // Gets a static instance of IAuthenticationProvider when the client app hasn't changed. 
                IAuthenticationProvider authProvider = AuthenticationHelpers.GetAuthProvider(authConfig);

                // Incremental scope consent without re-instanciating the auth provider. We will use a static instance.
                GraphRequestContext graphRequestContext = new GraphRequestContext();
                graphRequestContext.CancellationToken = cancellationToken;
                graphRequestContext.MiddlewareOptions = new Dictionary<string, IMiddlewareOption>
                {
                    {
                        typeof(AuthenticationHandlerOption).ToString(),
                        new AuthenticationHandlerOption
                        {
                            AuthenticationProviderOption = new AuthenticationProviderOption
                            {
                                Scopes = authConfig.Scopes,
                                ForceRefresh = ForceRefresh
                            }
                        }
                    }
                };
                HttpRequestMessage httpRequestMessage = new HttpRequestMessage(HttpMethod.Get, "https://graph.microsoft.com/v1.0/me");
                httpRequestMessage.Properties.Add(typeof(GraphRequestContext).ToString(), graphRequestContext);

                // Trigger consent.
                authProvider.AuthenticateRequestAsync(httpRequestMessage).GetAwaiter().GetResult();
            }
            catch (AuthenticationException authEx)
            {
                if ((authEx.InnerException is TaskCanceledException) && cancellationToken.IsCancellationRequested)
                    throw new Exception($"Device code terminal timed-out after {Constants.MaxDeviceCodeTimeOut} seconds. Please try again.");
                else
                    throw authEx.InnerException ?? authEx;
            }
            catch (Exception ex)
            {
                throw ex.InnerException ?? ex;
            }

            ConsoleColor previousColor = Console.ForegroundColor;
            Console.ForegroundColor = ConsoleColor.Green;
            WriteObject("Welcome To Microsoft Graph!");
            WriteObject(File.ReadAllText(Path.Combine(InstallationPath, ".\\Art\\Welcome.txt")));
            WriteObject(File.ReadAllText(Path.Combine(InstallationPath, ".\\Art\\Welcome2.txt")));
            WriteObject(File.ReadAllText(Path.Combine(InstallationPath, ".\\Art\\Welcome3.txt")));
            Console.ForegroundColor = previousColor;
        }

        protected override void StopProcessing()
        {
            base.StopProcessing();
        }

        private void validateParameters()
        {
            if (ParameterSetName == Constants.AppParameterSet)
            {
                // Client Id
                if (string.IsNullOrEmpty(ClientId))
                    ThrowParameterError(nameof(ClientId));

                // Client Secret
                if (string.IsNullOrEmpty(CertificateName))
                    ThrowParameterError(nameof(CertificateName));

                // Tenant Id
                if (string.IsNullOrEmpty(TenantId))
                    ThrowParameterError(nameof(TenantId));
            }
        }

        private void ThrowParameterError(string parameterName)
        {
            ThrowTerminatingError(
                new ErrorRecord(
                    new ArgumentException($"Must specify {parameterName}"), Guid.NewGuid().ToString(), ErrorCategory.InvalidArgument, null)
                );
        }
    }
}
