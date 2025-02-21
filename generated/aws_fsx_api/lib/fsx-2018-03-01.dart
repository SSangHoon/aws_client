// ignore_for_file: unused_element
// ignore_for_file: unused_field
// ignore_for_file: unused_import
// ignore_for_file: unused_local_variable
// ignore_for_file: unused_shown_name

import 'dart:convert';
import 'dart:typed_data';

import 'package:shared_aws_api/shared.dart' as _s;
import 'package:shared_aws_api/shared.dart'
    show
        rfc822ToJson,
        iso8601ToJson,
        unixTimestampToJson,
        nonNullableTimeStampFromJson,
        timeStampFromJson;

export 'package:shared_aws_api/shared.dart' show AwsClientCredentials;

/// Amazon FSx is a fully managed service that makes it easy for storage and
/// application administrators to launch and use shared file storage.
class FSx {
  final _s.JsonProtocol _protocol;
  FSx({
    required String region,
    _s.AwsClientCredentials? credentials,
    _s.AwsClientCredentialsProvider? credentialsProvider,
    _s.Client? client,
    String? endpointUrl,
  }) : _protocol = _s.JsonProtocol(
          client: client,
          service: _s.ServiceMetadata(
            endpointPrefix: 'fsx',
            signingName: 'fsx',
          ),
          region: region,
          credentials: credentials,
          credentialsProvider: credentialsProvider,
          endpointUrl: endpointUrl,
        );

  /// Closes the internal HTTP client if none was provided at creation.
  /// If a client was passed as a constructor argument, this becomes a noop.
  ///
  /// It's important to close all clients when it's done being used; failing to
  /// do so can cause the Dart process to hang.
  void close() {
    _protocol.close();
  }

  /// Use this action to associate one or more Domain Name Server (DNS) aliases
  /// with an existing Amazon FSx for Windows File Server file system. A file
  /// systen can have a maximum of 50 DNS aliases associated with it at any one
  /// time. If you try to associate a DNS alias that is already associated with
  /// the file system, FSx takes no action on that alias in the request. For
  /// more information, see <a
  /// href="https://docs.aws.amazon.com/fsx/latest/WindowsGuide/managing-dns-aliases.html">Working
  /// with DNS Aliases</a> and <a
  /// href="https://docs.aws.amazon.com/fsx/latest/WindowsGuide/walkthrough05-file-system-custom-CNAME.html">Walkthrough
  /// 5: Using DNS aliases to access your file system</a>, including additional
  /// steps you must take to be able to access your file system using a DNS
  /// alias.
  ///
  /// The system response shows the DNS aliases that Amazon FSx is attempting to
  /// associate with the file system. Use the API operation to monitor the
  /// status of the aliases Amazon FSx is associating with the file system.
  ///
  /// May throw [BadRequest].
  /// May throw [FileSystemNotFound].
  /// May throw [InternalServerError].
  ///
  /// Parameter [aliases] :
  /// An array of one or more DNS alias names to associate with the file system.
  /// The alias name has to comply with the following formatting requirements:
  ///
  /// <ul>
  /// <li>
  /// Formatted as a fully-qualified domain name (FQDN), <i>
  /// <code>hostname.domain</code> </i>, for example,
  /// <code>accounting.corp.example.com</code>.
  /// </li>
  /// <li>
  /// Can contain alphanumeric characters and the hyphen (-).
  /// </li>
  /// <li>
  /// Cannot start or end with a hyphen.
  /// </li>
  /// <li>
  /// Can start with a numeric.
  /// </li>
  /// </ul>
  /// For DNS alias names, Amazon FSx stores alphabetic characters as lowercase
  /// letters (a-z), regardless of how you specify them: as uppercase letters,
  /// lowercase letters, or the corresponding letters in escape codes.
  ///
  /// Parameter [fileSystemId] :
  /// Specifies the file system with which you want to associate one or more DNS
  /// aliases.
  Future<AssociateFileSystemAliasesResponse> associateFileSystemAliases({
    required List<String> aliases,
    required String fileSystemId,
    String? clientRequestToken,
  }) async {
    ArgumentError.checkNotNull(aliases, 'aliases');
    ArgumentError.checkNotNull(fileSystemId, 'fileSystemId');
    _s.validateStringLength(
      'fileSystemId',
      fileSystemId,
      11,
      21,
      isRequired: true,
    );
    _s.validateStringLength(
      'clientRequestToken',
      clientRequestToken,
      1,
      63,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSSimbaAPIService_v20180301.AssociateFileSystemAliases'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'Aliases': aliases,
        'FileSystemId': fileSystemId,
        'ClientRequestToken':
            clientRequestToken ?? _s.generateIdempotencyToken(),
      },
    );

    return AssociateFileSystemAliasesResponse.fromJson(jsonResponse.body);
  }

  /// Cancels an existing Amazon FSx for Lustre data repository task if that
  /// task is in either the <code>PENDING</code> or <code>EXECUTING</code>
  /// state. When you cancel a task, Amazon FSx does the following.
  ///
  /// <ul>
  /// <li>
  /// Any files that FSx has already exported are not reverted.
  /// </li>
  /// <li>
  /// FSx continues to export any files that are "in-flight" when the cancel
  /// operation is received.
  /// </li>
  /// <li>
  /// FSx does not export any files that have not yet been exported.
  /// </li>
  /// </ul>
  ///
  /// May throw [BadRequest].
  /// May throw [UnsupportedOperation].
  /// May throw [DataRepositoryTaskNotFound].
  /// May throw [DataRepositoryTaskEnded].
  /// May throw [InternalServerError].
  ///
  /// Parameter [taskId] :
  /// Specifies the data repository task to cancel.
  Future<CancelDataRepositoryTaskResponse> cancelDataRepositoryTask({
    required String taskId,
  }) async {
    ArgumentError.checkNotNull(taskId, 'taskId');
    _s.validateStringLength(
      'taskId',
      taskId,
      12,
      128,
      isRequired: true,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSSimbaAPIService_v20180301.CancelDataRepositoryTask'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'TaskId': taskId,
      },
    );

    return CancelDataRepositoryTaskResponse.fromJson(jsonResponse.body);
  }

  /// Creates a backup of an existing Amazon FSx file system. Creating regular
  /// backups for your file system is a best practice, enabling you to restore a
  /// file system from a backup if an issue arises with the original file
  /// system.
  ///
  /// For Amazon FSx for Lustre file systems, you can create a backup only for
  /// file systems with the following configuration:
  ///
  /// <ul>
  /// <li>
  /// a Persistent deployment type
  /// </li>
  /// <li>
  /// is <i>not</i> linked to a data respository.
  /// </li>
  /// </ul>
  /// For more information about backing up Amazon FSx for Lustre file systems,
  /// see <a
  /// href="https://docs.aws.amazon.com/fsx/latest/LustreGuide/using-backups-fsx.html">Working
  /// with FSx for Lustre backups</a>.
  ///
  /// For more information about backing up Amazon FSx for Windows file systems,
  /// see <a
  /// href="https://docs.aws.amazon.com/fsx/latest/WindowsGuide/using-backups.html">Working
  /// with FSx for Windows backups</a>.
  ///
  /// If a backup with the specified client request token exists, and the
  /// parameters match, this operation returns the description of the existing
  /// backup. If a backup specified client request token exists, and the
  /// parameters don't match, this operation returns
  /// <code>IncompatibleParameterError</code>. If a backup with the specified
  /// client request token doesn't exist, <code>CreateBackup</code> does the
  /// following:
  ///
  /// <ul>
  /// <li>
  /// Creates a new Amazon FSx backup with an assigned ID, and an initial
  /// lifecycle state of <code>CREATING</code>.
  /// </li>
  /// <li>
  /// Returns the description of the backup.
  /// </li>
  /// </ul>
  /// By using the idempotent operation, you can retry a
  /// <code>CreateBackup</code> operation without the risk of creating an extra
  /// backup. This approach can be useful when an initial call fails in a way
  /// that makes it unclear whether a backup was created. If you use the same
  /// client request token and the initial call created a backup, the operation
  /// returns a successful result because all the parameters are the same.
  ///
  /// The <code>CreateBackup</code> operation returns while the backup's
  /// lifecycle state is still <code>CREATING</code>. You can check the backup
  /// creation status by calling the <a>DescribeBackups</a> operation, which
  /// returns the backup state along with other information.
  ///
  /// May throw [BadRequest].
  /// May throw [UnsupportedOperation].
  /// May throw [FileSystemNotFound].
  /// May throw [BackupInProgress].
  /// May throw [IncompatibleParameterError].
  /// May throw [ServiceLimitExceeded].
  /// May throw [InternalServerError].
  ///
  /// Parameter [fileSystemId] :
  /// The ID of the file system to back up.
  ///
  /// Parameter [clientRequestToken] :
  /// (Optional) A string of up to 64 ASCII characters that Amazon FSx uses to
  /// ensure idempotent creation. This string is automatically filled on your
  /// behalf when you use the AWS Command Line Interface (AWS CLI) or an AWS
  /// SDK.
  ///
  /// Parameter [tags] :
  /// (Optional) The tags to apply to the backup at backup creation. The key
  /// value of the <code>Name</code> tag appears in the console as the backup
  /// name. If you have set <code>CopyTagsToBackups</code> to true, and you
  /// specify one or more tags using the <code>CreateBackup</code> action, no
  /// existing file system tags are copied from the file system to the backup.
  Future<CreateBackupResponse> createBackup({
    required String fileSystemId,
    String? clientRequestToken,
    List<Tag>? tags,
  }) async {
    ArgumentError.checkNotNull(fileSystemId, 'fileSystemId');
    _s.validateStringLength(
      'fileSystemId',
      fileSystemId,
      11,
      21,
      isRequired: true,
    );
    _s.validateStringLength(
      'clientRequestToken',
      clientRequestToken,
      1,
      63,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSSimbaAPIService_v20180301.CreateBackup'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'FileSystemId': fileSystemId,
        'ClientRequestToken':
            clientRequestToken ?? _s.generateIdempotencyToken(),
        if (tags != null) 'Tags': tags,
      },
    );

    return CreateBackupResponse.fromJson(jsonResponse.body);
  }

  /// Creates an Amazon FSx for Lustre data repository task. You use data
  /// repository tasks to perform bulk operations between your Amazon FSx file
  /// system and its linked data repository. An example of a data repository
  /// task is exporting any data and metadata changes, including POSIX metadata,
  /// to files, directories, and symbolic links (symlinks) from your FSx file
  /// system to its linked data repository. A
  /// <code>CreateDataRepositoryTask</code> operation will fail if a data
  /// repository is not linked to the FSx file system. To learn more about data
  /// repository tasks, see <a
  /// href="https://docs.aws.amazon.com/fsx/latest/LustreGuide/data-repository-tasks.html">Data
  /// Repository Tasks</a>. To learn more about linking a data repository to
  /// your file system, see <a
  /// href="https://docs.aws.amazon.com/fsx/latest/LustreGuide/create-fs-linked-data-repo.html">Linking
  /// your file system to an S3 bucket</a>.
  ///
  /// May throw [BadRequest].
  /// May throw [UnsupportedOperation].
  /// May throw [FileSystemNotFound].
  /// May throw [IncompatibleParameterError].
  /// May throw [ServiceLimitExceeded].
  /// May throw [InternalServerError].
  /// May throw [DataRepositoryTaskExecuting].
  ///
  /// Parameter [report] :
  /// Defines whether or not Amazon FSx provides a CompletionReport once the
  /// task has completed. A CompletionReport provides a detailed report on the
  /// files that Amazon FSx processed that meet the criteria specified by the
  /// <code>Scope</code> parameter. For more information, see <a
  /// href="https://docs.aws.amazon.com/fsx/latest/LustreGuide/task-completion-report.html">Working
  /// with Task Completion Reports</a>.
  ///
  /// Parameter [type] :
  /// Specifies the type of data repository task to create.
  ///
  /// Parameter [paths] :
  /// (Optional) The path or paths on the Amazon FSx file system to use when the
  /// data repository task is processed. The default path is the file system
  /// root directory. The paths you provide need to be relative to the mount
  /// point of the file system. If the mount point is <code>/mnt/fsx</code> and
  /// <code>/mnt/fsx/path1</code> is a directory or file on the file system you
  /// want to export, then the path to provide is <code>path1</code>. If a path
  /// that you provide isn't valid, the task fails.
  Future<CreateDataRepositoryTaskResponse> createDataRepositoryTask({
    required String fileSystemId,
    required CompletionReport report,
    required DataRepositoryTaskType type,
    String? clientRequestToken,
    List<String>? paths,
    List<Tag>? tags,
  }) async {
    ArgumentError.checkNotNull(fileSystemId, 'fileSystemId');
    _s.validateStringLength(
      'fileSystemId',
      fileSystemId,
      11,
      21,
      isRequired: true,
    );
    ArgumentError.checkNotNull(report, 'report');
    ArgumentError.checkNotNull(type, 'type');
    _s.validateStringLength(
      'clientRequestToken',
      clientRequestToken,
      1,
      63,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSSimbaAPIService_v20180301.CreateDataRepositoryTask'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'FileSystemId': fileSystemId,
        'Report': report,
        'Type': type.toValue(),
        'ClientRequestToken':
            clientRequestToken ?? _s.generateIdempotencyToken(),
        if (paths != null) 'Paths': paths,
        if (tags != null) 'Tags': tags,
      },
    );

    return CreateDataRepositoryTaskResponse.fromJson(jsonResponse.body);
  }

  /// Creates a new, empty Amazon FSx file system.
  ///
  /// If a file system with the specified client request token exists and the
  /// parameters match, <code>CreateFileSystem</code> returns the description of
  /// the existing file system. If a file system specified client request token
  /// exists and the parameters don't match, this call returns
  /// <code>IncompatibleParameterError</code>. If a file system with the
  /// specified client request token doesn't exist,
  /// <code>CreateFileSystem</code> does the following:
  ///
  /// <ul>
  /// <li>
  /// Creates a new, empty Amazon FSx file system with an assigned ID, and an
  /// initial lifecycle state of <code>CREATING</code>.
  /// </li>
  /// <li>
  /// Returns the description of the file system.
  /// </li>
  /// </ul>
  /// This operation requires a client request token in the request that Amazon
  /// FSx uses to ensure idempotent creation. This means that calling the
  /// operation multiple times with the same client request token has no effect.
  /// By using the idempotent operation, you can retry a
  /// <code>CreateFileSystem</code> operation without the risk of creating an
  /// extra file system. This approach can be useful when an initial call fails
  /// in a way that makes it unclear whether a file system was created. Examples
  /// are if a transport level timeout occurred, or your connection was reset.
  /// If you use the same client request token and the initial call created a
  /// file system, the client receives success as long as the parameters are the
  /// same.
  /// <note>
  /// The <code>CreateFileSystem</code> call returns while the file system's
  /// lifecycle state is still <code>CREATING</code>. You can check the
  /// file-system creation status by calling the <a>DescribeFileSystems</a>
  /// operation, which returns the file system state along with other
  /// information.
  /// </note>
  ///
  /// May throw [BadRequest].
  /// May throw [ActiveDirectoryError].
  /// May throw [IncompatibleParameterError].
  /// May throw [InvalidImportPath].
  /// May throw [InvalidExportPath].
  /// May throw [InvalidNetworkSettings].
  /// May throw [InvalidPerUnitStorageThroughput].
  /// May throw [ServiceLimitExceeded].
  /// May throw [InternalServerError].
  /// May throw [MissingFileSystemConfiguration].
  ///
  /// Parameter [fileSystemType] :
  /// The type of Amazon FSx file system to create, either <code>WINDOWS</code>
  /// or <code>LUSTRE</code>.
  ///
  /// Parameter [storageCapacity] :
  /// Sets the storage capacity of the file system that you're creating.
  ///
  /// For Lustre file systems:
  ///
  /// <ul>
  /// <li>
  /// For <code>SCRATCH_2</code> and <code>PERSISTENT_1 SSD</code> deployment
  /// types, valid values are 1200 GiB, 2400 GiB, and increments of 2400 GiB.
  /// </li>
  /// <li>
  /// For <code>PERSISTENT HDD</code> file systems, valid values are increments
  /// of 6000 GiB for 12 MB/s/TiB file systems and increments of 1800 GiB for 40
  /// MB/s/TiB file systems.
  /// </li>
  /// <li>
  /// For <code>SCRATCH_1</code> deployment type, valid values are 1200 GiB,
  /// 2400 GiB, and increments of 3600 GiB.
  /// </li>
  /// </ul>
  /// For Windows file systems:
  ///
  /// <ul>
  /// <li>
  /// If <code>StorageType=SSD</code>, valid values are 32 GiB - 65,536 GiB (64
  /// TiB).
  /// </li>
  /// <li>
  /// If <code>StorageType=HDD</code>, valid values are 2000 GiB - 65,536 GiB
  /// (64 TiB).
  /// </li>
  /// </ul>
  ///
  /// Parameter [subnetIds] :
  /// Specifies the IDs of the subnets that the file system will be accessible
  /// from. For Windows <code>MULTI_AZ_1</code> file system deployment types,
  /// provide exactly two subnet IDs, one for the preferred file server and one
  /// for the standby file server. You specify one of these subnets as the
  /// preferred subnet using the <code>WindowsConfiguration &gt;
  /// PreferredSubnetID</code> property.
  ///
  /// For Windows <code>SINGLE_AZ_1</code> and <code>SINGLE_AZ_2</code> file
  /// system deployment types and Lustre file systems, provide exactly one
  /// subnet ID. The file server is launched in that subnet's Availability Zone.
  ///
  /// Parameter [clientRequestToken] :
  /// A string of up to 64 ASCII characters that Amazon FSx uses to ensure
  /// idempotent creation. This string is automatically filled on your behalf
  /// when you use the AWS Command Line Interface (AWS CLI) or an AWS SDK.
  ///
  /// Parameter [securityGroupIds] :
  /// A list of IDs specifying the security groups to apply to all network
  /// interfaces created for file system access. This list isn't returned in
  /// later requests to describe the file system.
  ///
  /// Parameter [storageType] :
  /// Sets the storage type for the file system you're creating. Valid values
  /// are <code>SSD</code> and <code>HDD</code>.
  ///
  /// <ul>
  /// <li>
  /// Set to <code>SSD</code> to use solid state drive storage. SSD is supported
  /// on all Windows and Lustre deployment types.
  /// </li>
  /// <li>
  /// Set to <code>HDD</code> to use hard disk drive storage. HDD is supported
  /// on <code>SINGLE_AZ_2</code> and <code>MULTI_AZ_1</code> Windows file
  /// system deployment types, and on <code>PERSISTENT</code> Lustre file system
  /// deployment types.
  /// </li>
  /// </ul>
  /// Default value is <code>SSD</code>. For more information, see <a
  /// href="https://docs.aws.amazon.com/fsx/latest/WindowsGuide/optimize-fsx-costs.html#storage-type-options">
  /// Storage Type Options</a> in the <i>Amazon FSx for Windows User Guide</i>
  /// and <a
  /// href="https://docs.aws.amazon.com/fsx/latest/LustreGuide/what-is.html#storage-options">Multiple
  /// Storage Options</a> in the <i>Amazon FSx for Lustre User Guide</i>.
  ///
  /// Parameter [tags] :
  /// The tags to apply to the file system being created. The key value of the
  /// <code>Name</code> tag appears in the console as the file system name.
  ///
  /// Parameter [windowsConfiguration] :
  /// The Microsoft Windows configuration for the file system being created.
  Future<CreateFileSystemResponse> createFileSystem({
    required FileSystemType fileSystemType,
    required int storageCapacity,
    required List<String> subnetIds,
    String? clientRequestToken,
    String? kmsKeyId,
    CreateFileSystemLustreConfiguration? lustreConfiguration,
    List<String>? securityGroupIds,
    StorageType? storageType,
    List<Tag>? tags,
    CreateFileSystemWindowsConfiguration? windowsConfiguration,
  }) async {
    ArgumentError.checkNotNull(fileSystemType, 'fileSystemType');
    ArgumentError.checkNotNull(storageCapacity, 'storageCapacity');
    _s.validateNumRange(
      'storageCapacity',
      storageCapacity,
      0,
      2147483647,
      isRequired: true,
    );
    ArgumentError.checkNotNull(subnetIds, 'subnetIds');
    _s.validateStringLength(
      'clientRequestToken',
      clientRequestToken,
      1,
      63,
    );
    _s.validateStringLength(
      'kmsKeyId',
      kmsKeyId,
      1,
      2048,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSSimbaAPIService_v20180301.CreateFileSystem'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'FileSystemType': fileSystemType.toValue(),
        'StorageCapacity': storageCapacity,
        'SubnetIds': subnetIds,
        'ClientRequestToken':
            clientRequestToken ?? _s.generateIdempotencyToken(),
        if (kmsKeyId != null) 'KmsKeyId': kmsKeyId,
        if (lustreConfiguration != null)
          'LustreConfiguration': lustreConfiguration,
        if (securityGroupIds != null) 'SecurityGroupIds': securityGroupIds,
        if (storageType != null) 'StorageType': storageType.toValue(),
        if (tags != null) 'Tags': tags,
        if (windowsConfiguration != null)
          'WindowsConfiguration': windowsConfiguration,
      },
    );

    return CreateFileSystemResponse.fromJson(jsonResponse.body);
  }

  /// Creates a new Amazon FSx file system from an existing Amazon FSx backup.
  ///
  /// If a file system with the specified client request token exists and the
  /// parameters match, this operation returns the description of the file
  /// system. If a client request token specified by the file system exists and
  /// the parameters don't match, this call returns
  /// <code>IncompatibleParameterError</code>. If a file system with the
  /// specified client request token doesn't exist, this operation does the
  /// following:
  ///
  /// <ul>
  /// <li>
  /// Creates a new Amazon FSx file system from backup with an assigned ID, and
  /// an initial lifecycle state of <code>CREATING</code>.
  /// </li>
  /// <li>
  /// Returns the description of the file system.
  /// </li>
  /// </ul>
  /// Parameters like Active Directory, default share name, automatic backup,
  /// and backup settings default to the parameters of the file system that was
  /// backed up, unless overridden. You can explicitly supply other settings.
  ///
  /// By using the idempotent operation, you can retry a
  /// <code>CreateFileSystemFromBackup</code> call without the risk of creating
  /// an extra file system. This approach can be useful when an initial call
  /// fails in a way that makes it unclear whether a file system was created.
  /// Examples are if a transport level timeout occurred, or your connection was
  /// reset. If you use the same client request token and the initial call
  /// created a file system, the client receives success as long as the
  /// parameters are the same.
  /// <note>
  /// The <code>CreateFileSystemFromBackup</code> call returns while the file
  /// system's lifecycle state is still <code>CREATING</code>. You can check the
  /// file-system creation status by calling the <a>DescribeFileSystems</a>
  /// operation, which returns the file system state along with other
  /// information.
  /// </note>
  ///
  /// May throw [BadRequest].
  /// May throw [ActiveDirectoryError].
  /// May throw [IncompatibleParameterError].
  /// May throw [InvalidNetworkSettings].
  /// May throw [InvalidPerUnitStorageThroughput].
  /// May throw [ServiceLimitExceeded].
  /// May throw [BackupNotFound].
  /// May throw [InternalServerError].
  /// May throw [MissingFileSystemConfiguration].
  ///
  /// Parameter [subnetIds] :
  /// Specifies the IDs of the subnets that the file system will be accessible
  /// from. For Windows <code>MULTI_AZ_1</code> file system deployment types,
  /// provide exactly two subnet IDs, one for the preferred file server and one
  /// for the standby file server. You specify one of these subnets as the
  /// preferred subnet using the <code>WindowsConfiguration &gt;
  /// PreferredSubnetID</code> property.
  ///
  /// For Windows <code>SINGLE_AZ_1</code> and <code>SINGLE_AZ_2</code>
  /// deployment types and Lustre file systems, provide exactly one subnet ID.
  /// The file server is launched in that subnet's Availability Zone.
  ///
  /// Parameter [clientRequestToken] :
  /// A string of up to 64 ASCII characters that Amazon FSx uses to ensure
  /// idempotent creation. This string is automatically filled on your behalf
  /// when you use the AWS Command Line Interface (AWS CLI) or an AWS SDK.
  ///
  /// Parameter [securityGroupIds] :
  /// A list of IDs for the security groups that apply to the specified network
  /// interfaces created for file system access. These security groups apply to
  /// all network interfaces. This value isn't returned in later
  /// DescribeFileSystem requests.
  ///
  /// Parameter [storageType] :
  /// Sets the storage type for the Windows file system you're creating from a
  /// backup. Valid values are <code>SSD</code> and <code>HDD</code>.
  ///
  /// <ul>
  /// <li>
  /// Set to <code>SSD</code> to use solid state drive storage. Supported on all
  /// Windows deployment types.
  /// </li>
  /// <li>
  /// Set to <code>HDD</code> to use hard disk drive storage. Supported on
  /// <code>SINGLE_AZ_2</code> and <code>MULTI_AZ_1</code> Windows file system
  /// deployment types.
  /// </li>
  /// </ul>
  /// Default value is <code>SSD</code>.
  /// <note>
  /// HDD and SSD storage types have different minimum storage capacity
  /// requirements. A restored file system's storage capacity is tied to the
  /// file system that was backed up. You can create a file system that uses HDD
  /// storage from a backup of a file system that used SSD storage only if the
  /// original SSD file system had a storage capacity of at least 2000 GiB.
  /// </note>
  ///
  /// Parameter [tags] :
  /// The tags to be applied to the file system at file system creation. The key
  /// value of the <code>Name</code> tag appears in the console as the file
  /// system name.
  ///
  /// Parameter [windowsConfiguration] :
  /// The configuration for this Microsoft Windows file system.
  Future<CreateFileSystemFromBackupResponse> createFileSystemFromBackup({
    required String backupId,
    required List<String> subnetIds,
    String? clientRequestToken,
    CreateFileSystemLustreConfiguration? lustreConfiguration,
    List<String>? securityGroupIds,
    StorageType? storageType,
    List<Tag>? tags,
    CreateFileSystemWindowsConfiguration? windowsConfiguration,
  }) async {
    ArgumentError.checkNotNull(backupId, 'backupId');
    _s.validateStringLength(
      'backupId',
      backupId,
      12,
      128,
      isRequired: true,
    );
    ArgumentError.checkNotNull(subnetIds, 'subnetIds');
    _s.validateStringLength(
      'clientRequestToken',
      clientRequestToken,
      1,
      63,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSSimbaAPIService_v20180301.CreateFileSystemFromBackup'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'BackupId': backupId,
        'SubnetIds': subnetIds,
        'ClientRequestToken':
            clientRequestToken ?? _s.generateIdempotencyToken(),
        if (lustreConfiguration != null)
          'LustreConfiguration': lustreConfiguration,
        if (securityGroupIds != null) 'SecurityGroupIds': securityGroupIds,
        if (storageType != null) 'StorageType': storageType.toValue(),
        if (tags != null) 'Tags': tags,
        if (windowsConfiguration != null)
          'WindowsConfiguration': windowsConfiguration,
      },
    );

    return CreateFileSystemFromBackupResponse.fromJson(jsonResponse.body);
  }

  /// Deletes an Amazon FSx backup, deleting its contents. After deletion, the
  /// backup no longer exists, and its data is gone.
  ///
  /// The <code>DeleteBackup</code> call returns instantly. The backup will not
  /// show up in later <code>DescribeBackups</code> calls.
  /// <important>
  /// The data in a deleted backup is also deleted and can't be recovered by any
  /// means.
  /// </important>
  ///
  /// May throw [BadRequest].
  /// May throw [BackupInProgress].
  /// May throw [BackupNotFound].
  /// May throw [BackupRestoring].
  /// May throw [IncompatibleParameterError].
  /// May throw [InternalServerError].
  ///
  /// Parameter [backupId] :
  /// The ID of the backup you want to delete.
  ///
  /// Parameter [clientRequestToken] :
  /// A string of up to 64 ASCII characters that Amazon FSx uses to ensure
  /// idempotent deletion. This is automatically filled on your behalf when
  /// using the AWS CLI or SDK.
  Future<DeleteBackupResponse> deleteBackup({
    required String backupId,
    String? clientRequestToken,
  }) async {
    ArgumentError.checkNotNull(backupId, 'backupId');
    _s.validateStringLength(
      'backupId',
      backupId,
      12,
      128,
      isRequired: true,
    );
    _s.validateStringLength(
      'clientRequestToken',
      clientRequestToken,
      1,
      63,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSSimbaAPIService_v20180301.DeleteBackup'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'BackupId': backupId,
        'ClientRequestToken':
            clientRequestToken ?? _s.generateIdempotencyToken(),
      },
    );

    return DeleteBackupResponse.fromJson(jsonResponse.body);
  }

  /// Deletes a file system, deleting its contents. After deletion, the file
  /// system no longer exists, and its data is gone. Any existing automatic
  /// backups will also be deleted.
  ///
  /// By default, when you delete an Amazon FSx for Windows File Server file
  /// system, a final backup is created upon deletion. This final backup is not
  /// subject to the file system's retention policy, and must be manually
  /// deleted.
  ///
  /// The <code>DeleteFileSystem</code> action returns while the file system has
  /// the <code>DELETING</code> status. You can check the file system deletion
  /// status by calling the <a>DescribeFileSystems</a> action, which returns a
  /// list of file systems in your account. If you pass the file system ID for a
  /// deleted file system, the <a>DescribeFileSystems</a> returns a
  /// <code>FileSystemNotFound</code> error.
  /// <note>
  /// Deleting an Amazon FSx for Lustre file system will fail with a 400
  /// BadRequest if a data repository task is in a <code>PENDING</code> or
  /// <code>EXECUTING</code> state.
  /// </note> <important>
  /// The data in a deleted file system is also deleted and can't be recovered
  /// by any means.
  /// </important>
  ///
  /// May throw [BadRequest].
  /// May throw [IncompatibleParameterError].
  /// May throw [FileSystemNotFound].
  /// May throw [ServiceLimitExceeded].
  /// May throw [InternalServerError].
  ///
  /// Parameter [fileSystemId] :
  /// The ID of the file system you want to delete.
  ///
  /// Parameter [clientRequestToken] :
  /// A string of up to 64 ASCII characters that Amazon FSx uses to ensure
  /// idempotent deletion. This is automatically filled on your behalf when
  /// using the AWS CLI or SDK.
  Future<DeleteFileSystemResponse> deleteFileSystem({
    required String fileSystemId,
    String? clientRequestToken,
    DeleteFileSystemLustreConfiguration? lustreConfiguration,
    DeleteFileSystemWindowsConfiguration? windowsConfiguration,
  }) async {
    ArgumentError.checkNotNull(fileSystemId, 'fileSystemId');
    _s.validateStringLength(
      'fileSystemId',
      fileSystemId,
      11,
      21,
      isRequired: true,
    );
    _s.validateStringLength(
      'clientRequestToken',
      clientRequestToken,
      1,
      63,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSSimbaAPIService_v20180301.DeleteFileSystem'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'FileSystemId': fileSystemId,
        'ClientRequestToken':
            clientRequestToken ?? _s.generateIdempotencyToken(),
        if (lustreConfiguration != null)
          'LustreConfiguration': lustreConfiguration,
        if (windowsConfiguration != null)
          'WindowsConfiguration': windowsConfiguration,
      },
    );

    return DeleteFileSystemResponse.fromJson(jsonResponse.body);
  }

  /// Returns the description of specific Amazon FSx backups, if a
  /// <code>BackupIds</code> value is provided for that backup. Otherwise, it
  /// returns all backups owned by your AWS account in the AWS Region of the
  /// endpoint that you're calling.
  ///
  /// When retrieving all backups, you can optionally specify the
  /// <code>MaxResults</code> parameter to limit the number of backups in a
  /// response. If more backups remain, Amazon FSx returns a
  /// <code>NextToken</code> value in the response. In this case, send a later
  /// request with the <code>NextToken</code> request parameter set to the value
  /// of <code>NextToken</code> from the last response.
  ///
  /// This action is used in an iterative process to retrieve a list of your
  /// backups. <code>DescribeBackups</code> is called first without a
  /// <code>NextToken</code>value. Then the action continues to be called with
  /// the <code>NextToken</code> parameter set to the value of the last
  /// <code>NextToken</code> value until a response has no
  /// <code>NextToken</code>.
  ///
  /// When using this action, keep the following in mind:
  ///
  /// <ul>
  /// <li>
  /// The implementation might return fewer than <code>MaxResults</code> file
  /// system descriptions while still including a <code>NextToken</code> value.
  /// </li>
  /// <li>
  /// The order of backups returned in the response of one
  /// <code>DescribeBackups</code> call and the order of backups returned across
  /// the responses of a multi-call iteration is unspecified.
  /// </li>
  /// </ul>
  ///
  /// May throw [BadRequest].
  /// May throw [FileSystemNotFound].
  /// May throw [BackupNotFound].
  /// May throw [InternalServerError].
  ///
  /// Parameter [backupIds] :
  /// IDs of the backups you want to retrieve (String). This overrides any
  /// filters. If any IDs are not found, BackupNotFound will be thrown.
  ///
  /// Parameter [filters] :
  /// Filters structure. Supported names are file-system-id and backup-type.
  ///
  /// Parameter [maxResults] :
  /// Maximum number of backups to return in the response (integer). This
  /// parameter value must be greater than 0. The number of items that Amazon
  /// FSx returns is the minimum of the <code>MaxResults</code> parameter
  /// specified in the request and the service's internal maximum number of
  /// items per page.
  ///
  /// Parameter [nextToken] :
  /// Opaque pagination token returned from a previous
  /// <code>DescribeBackups</code> operation (String). If a token present, the
  /// action continues the list from where the returning call left off.
  Future<DescribeBackupsResponse> describeBackups({
    List<String>? backupIds,
    List<Filter>? filters,
    int? maxResults,
    String? nextToken,
  }) async {
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      2147483647,
    );
    _s.validateStringLength(
      'nextToken',
      nextToken,
      1,
      255,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSSimbaAPIService_v20180301.DescribeBackups'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        if (backupIds != null) 'BackupIds': backupIds,
        if (filters != null) 'Filters': filters,
        if (maxResults != null) 'MaxResults': maxResults,
        if (nextToken != null) 'NextToken': nextToken,
      },
    );

    return DescribeBackupsResponse.fromJson(jsonResponse.body);
  }

  /// Returns the description of specific Amazon FSx for Lustre data repository
  /// tasks, if one or more <code>TaskIds</code> values are provided in the
  /// request, or if filters are used in the request. You can use filters to
  /// narrow the response to include just tasks for specific file systems, or
  /// tasks in a specific lifecycle state. Otherwise, it returns all data
  /// repository tasks owned by your AWS account in the AWS Region of the
  /// endpoint that you're calling.
  ///
  /// When retrieving all tasks, you can paginate the response by using the
  /// optional <code>MaxResults</code> parameter to limit the number of tasks
  /// returned in a response. If more tasks remain, Amazon FSx returns a
  /// <code>NextToken</code> value in the response. In this case, send a later
  /// request with the <code>NextToken</code> request parameter set to the value
  /// of <code>NextToken</code> from the last response.
  ///
  /// May throw [BadRequest].
  /// May throw [FileSystemNotFound].
  /// May throw [DataRepositoryTaskNotFound].
  /// May throw [InternalServerError].
  ///
  /// Parameter [filters] :
  /// (Optional) You can use filters to narrow the
  /// <code>DescribeDataRepositoryTasks</code> response to include just tasks
  /// for specific file systems, or tasks in a specific lifecycle state.
  ///
  /// Parameter [taskIds] :
  /// (Optional) IDs of the tasks whose descriptions you want to retrieve
  /// (String).
  Future<DescribeDataRepositoryTasksResponse> describeDataRepositoryTasks({
    List<DataRepositoryTaskFilter>? filters,
    int? maxResults,
    String? nextToken,
    List<String>? taskIds,
  }) async {
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      2147483647,
    );
    _s.validateStringLength(
      'nextToken',
      nextToken,
      1,
      255,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSSimbaAPIService_v20180301.DescribeDataRepositoryTasks'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        if (filters != null) 'Filters': filters,
        if (maxResults != null) 'MaxResults': maxResults,
        if (nextToken != null) 'NextToken': nextToken,
        if (taskIds != null) 'TaskIds': taskIds,
      },
    );

    return DescribeDataRepositoryTasksResponse.fromJson(jsonResponse.body);
  }

  /// Returns the DNS aliases that are associated with the specified Amazon FSx
  /// for Windows File Server file system. A history of all DNS aliases that
  /// have been associated with and disassociated from the file system is
  /// available in the list of <a>AdministrativeAction</a> provided in the
  /// <a>DescribeFileSystems</a> operation response.
  ///
  /// May throw [BadRequest].
  /// May throw [FileSystemNotFound].
  /// May throw [InternalServerError].
  ///
  /// Parameter [fileSystemId] :
  /// The ID of the file system to return the associated DNS aliases for
  /// (String).
  ///
  /// Parameter [maxResults] :
  /// Maximum number of DNS aliases to return in the response (integer). This
  /// parameter value must be greater than 0. The number of items that Amazon
  /// FSx returns is the minimum of the <code>MaxResults</code> parameter
  /// specified in the request and the service's internal maximum number of
  /// items per page.
  ///
  /// Parameter [nextToken] :
  /// Opaque pagination token returned from a previous
  /// <code>DescribeFileSystemAliases</code> operation (String). If a token is
  /// included in the request, the action continues the list from where the
  /// previous returning call left off.
  Future<DescribeFileSystemAliasesResponse> describeFileSystemAliases({
    required String fileSystemId,
    String? clientRequestToken,
    int? maxResults,
    String? nextToken,
  }) async {
    ArgumentError.checkNotNull(fileSystemId, 'fileSystemId');
    _s.validateStringLength(
      'fileSystemId',
      fileSystemId,
      11,
      21,
      isRequired: true,
    );
    _s.validateStringLength(
      'clientRequestToken',
      clientRequestToken,
      1,
      63,
    );
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      2147483647,
    );
    _s.validateStringLength(
      'nextToken',
      nextToken,
      1,
      255,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSSimbaAPIService_v20180301.DescribeFileSystemAliases'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'FileSystemId': fileSystemId,
        'ClientRequestToken':
            clientRequestToken ?? _s.generateIdempotencyToken(),
        if (maxResults != null) 'MaxResults': maxResults,
        if (nextToken != null) 'NextToken': nextToken,
      },
    );

    return DescribeFileSystemAliasesResponse.fromJson(jsonResponse.body);
  }

  /// Returns the description of specific Amazon FSx file systems, if a
  /// <code>FileSystemIds</code> value is provided for that file system.
  /// Otherwise, it returns descriptions of all file systems owned by your AWS
  /// account in the AWS Region of the endpoint that you're calling.
  ///
  /// When retrieving all file system descriptions, you can optionally specify
  /// the <code>MaxResults</code> parameter to limit the number of descriptions
  /// in a response. If more file system descriptions remain, Amazon FSx returns
  /// a <code>NextToken</code> value in the response. In this case, send a later
  /// request with the <code>NextToken</code> request parameter set to the value
  /// of <code>NextToken</code> from the last response.
  ///
  /// This action is used in an iterative process to retrieve a list of your
  /// file system descriptions. <code>DescribeFileSystems</code> is called first
  /// without a <code>NextToken</code>value. Then the action continues to be
  /// called with the <code>NextToken</code> parameter set to the value of the
  /// last <code>NextToken</code> value until a response has no
  /// <code>NextToken</code>.
  ///
  /// When using this action, keep the following in mind:
  ///
  /// <ul>
  /// <li>
  /// The implementation might return fewer than <code>MaxResults</code> file
  /// system descriptions while still including a <code>NextToken</code> value.
  /// </li>
  /// <li>
  /// The order of file systems returned in the response of one
  /// <code>DescribeFileSystems</code> call and the order of file systems
  /// returned across the responses of a multicall iteration is unspecified.
  /// </li>
  /// </ul>
  ///
  /// May throw [BadRequest].
  /// May throw [FileSystemNotFound].
  /// May throw [InternalServerError].
  ///
  /// Parameter [fileSystemIds] :
  /// IDs of the file systems whose descriptions you want to retrieve (String).
  ///
  /// Parameter [maxResults] :
  /// Maximum number of file systems to return in the response (integer). This
  /// parameter value must be greater than 0. The number of items that Amazon
  /// FSx returns is the minimum of the <code>MaxResults</code> parameter
  /// specified in the request and the service's internal maximum number of
  /// items per page.
  ///
  /// Parameter [nextToken] :
  /// Opaque pagination token returned from a previous
  /// <code>DescribeFileSystems</code> operation (String). If a token present,
  /// the action continues the list from where the returning call left off.
  Future<DescribeFileSystemsResponse> describeFileSystems({
    List<String>? fileSystemIds,
    int? maxResults,
    String? nextToken,
  }) async {
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      2147483647,
    );
    _s.validateStringLength(
      'nextToken',
      nextToken,
      1,
      255,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSSimbaAPIService_v20180301.DescribeFileSystems'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        if (fileSystemIds != null) 'FileSystemIds': fileSystemIds,
        if (maxResults != null) 'MaxResults': maxResults,
        if (nextToken != null) 'NextToken': nextToken,
      },
    );

    return DescribeFileSystemsResponse.fromJson(jsonResponse.body);
  }

  /// Use this action to disassociate, or remove, one or more Domain Name
  /// Service (DNS) aliases from an Amazon FSx for Windows File Server file
  /// system. If you attempt to disassociate a DNS alias that is not associated
  /// with the file system, Amazon FSx responds with a 400 Bad Request. For more
  /// information, see <a
  /// href="https://docs.aws.amazon.com/fsx/latest/WindowsGuide/managing-dns-aliases.html">Working
  /// with DNS Aliases</a>.
  ///
  /// The system generated response showing the DNS aliases that Amazon FSx is
  /// attempting to disassociate from the file system. Use the API operation to
  /// monitor the status of the aliases Amazon FSx is disassociating with the
  /// file system.
  ///
  /// May throw [BadRequest].
  /// May throw [FileSystemNotFound].
  /// May throw [InternalServerError].
  ///
  /// Parameter [aliases] :
  /// An array of one or more DNS alias names to disassociate, or remove, from
  /// the file system.
  ///
  /// Parameter [fileSystemId] :
  /// Specifies the file system from which to disassociate the DNS aliases.
  Future<DisassociateFileSystemAliasesResponse> disassociateFileSystemAliases({
    required List<String> aliases,
    required String fileSystemId,
    String? clientRequestToken,
  }) async {
    ArgumentError.checkNotNull(aliases, 'aliases');
    ArgumentError.checkNotNull(fileSystemId, 'fileSystemId');
    _s.validateStringLength(
      'fileSystemId',
      fileSystemId,
      11,
      21,
      isRequired: true,
    );
    _s.validateStringLength(
      'clientRequestToken',
      clientRequestToken,
      1,
      63,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target':
          'AWSSimbaAPIService_v20180301.DisassociateFileSystemAliases'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'Aliases': aliases,
        'FileSystemId': fileSystemId,
        'ClientRequestToken':
            clientRequestToken ?? _s.generateIdempotencyToken(),
      },
    );

    return DisassociateFileSystemAliasesResponse.fromJson(jsonResponse.body);
  }

  /// Lists tags for an Amazon FSx file systems and backups in the case of
  /// Amazon FSx for Windows File Server.
  ///
  /// When retrieving all tags, you can optionally specify the
  /// <code>MaxResults</code> parameter to limit the number of tags in a
  /// response. If more tags remain, Amazon FSx returns a <code>NextToken</code>
  /// value in the response. In this case, send a later request with the
  /// <code>NextToken</code> request parameter set to the value of
  /// <code>NextToken</code> from the last response.
  ///
  /// This action is used in an iterative process to retrieve a list of your
  /// tags. <code>ListTagsForResource</code> is called first without a
  /// <code>NextToken</code>value. Then the action continues to be called with
  /// the <code>NextToken</code> parameter set to the value of the last
  /// <code>NextToken</code> value until a response has no
  /// <code>NextToken</code>.
  ///
  /// When using this action, keep the following in mind:
  ///
  /// <ul>
  /// <li>
  /// The implementation might return fewer than <code>MaxResults</code> file
  /// system descriptions while still including a <code>NextToken</code> value.
  /// </li>
  /// <li>
  /// The order of tags returned in the response of one
  /// <code>ListTagsForResource</code> call and the order of tags returned
  /// across the responses of a multi-call iteration is unspecified.
  /// </li>
  /// </ul>
  ///
  /// May throw [BadRequest].
  /// May throw [InternalServerError].
  /// May throw [ResourceNotFound].
  /// May throw [NotServiceResourceError].
  /// May throw [ResourceDoesNotSupportTagging].
  ///
  /// Parameter [resourceARN] :
  /// The ARN of the Amazon FSx resource that will have its tags listed.
  ///
  /// Parameter [maxResults] :
  /// Maximum number of tags to return in the response (integer). This parameter
  /// value must be greater than 0. The number of items that Amazon FSx returns
  /// is the minimum of the <code>MaxResults</code> parameter specified in the
  /// request and the service's internal maximum number of items per page.
  ///
  /// Parameter [nextToken] :
  /// Opaque pagination token returned from a previous
  /// <code>ListTagsForResource</code> operation (String). If a token present,
  /// the action continues the list from where the returning call left off.
  Future<ListTagsForResourceResponse> listTagsForResource({
    required String resourceARN,
    int? maxResults,
    String? nextToken,
  }) async {
    ArgumentError.checkNotNull(resourceARN, 'resourceARN');
    _s.validateStringLength(
      'resourceARN',
      resourceARN,
      8,
      512,
      isRequired: true,
    );
    _s.validateNumRange(
      'maxResults',
      maxResults,
      1,
      2147483647,
    );
    _s.validateStringLength(
      'nextToken',
      nextToken,
      1,
      255,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSSimbaAPIService_v20180301.ListTagsForResource'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'ResourceARN': resourceARN,
        if (maxResults != null) 'MaxResults': maxResults,
        if (nextToken != null) 'NextToken': nextToken,
      },
    );

    return ListTagsForResourceResponse.fromJson(jsonResponse.body);
  }

  /// Tags an Amazon FSx resource.
  ///
  /// May throw [BadRequest].
  /// May throw [InternalServerError].
  /// May throw [ResourceNotFound].
  /// May throw [NotServiceResourceError].
  /// May throw [ResourceDoesNotSupportTagging].
  ///
  /// Parameter [resourceARN] :
  /// The Amazon Resource Name (ARN) of the Amazon FSx resource that you want to
  /// tag.
  ///
  /// Parameter [tags] :
  /// A list of tags for the resource. If a tag with a given key already exists,
  /// the value is replaced by the one specified in this parameter.
  Future<void> tagResource({
    required String resourceARN,
    required List<Tag> tags,
  }) async {
    ArgumentError.checkNotNull(resourceARN, 'resourceARN');
    _s.validateStringLength(
      'resourceARN',
      resourceARN,
      8,
      512,
      isRequired: true,
    );
    ArgumentError.checkNotNull(tags, 'tags');
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSSimbaAPIService_v20180301.TagResource'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'ResourceARN': resourceARN,
        'Tags': tags,
      },
    );
  }

  /// This action removes a tag from an Amazon FSx resource.
  ///
  /// May throw [BadRequest].
  /// May throw [InternalServerError].
  /// May throw [ResourceNotFound].
  /// May throw [NotServiceResourceError].
  /// May throw [ResourceDoesNotSupportTagging].
  ///
  /// Parameter [resourceARN] :
  /// The ARN of the Amazon FSx resource to untag.
  ///
  /// Parameter [tagKeys] :
  /// A list of keys of tags on the resource to untag. In case the tag key
  /// doesn't exist, the call will still succeed to be idempotent.
  Future<void> untagResource({
    required String resourceARN,
    required List<String> tagKeys,
  }) async {
    ArgumentError.checkNotNull(resourceARN, 'resourceARN');
    _s.validateStringLength(
      'resourceARN',
      resourceARN,
      8,
      512,
      isRequired: true,
    );
    ArgumentError.checkNotNull(tagKeys, 'tagKeys');
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSSimbaAPIService_v20180301.UntagResource'
    };
    await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'ResourceARN': resourceARN,
        'TagKeys': tagKeys,
      },
    );
  }

  /// Use this operation to update the configuration of an existing Amazon FSx
  /// file system. You can update multiple properties in a single request.
  ///
  /// For Amazon FSx for Windows File Server file systems, you can update the
  /// following properties:
  ///
  /// <ul>
  /// <li>
  /// AutomaticBackupRetentionDays
  /// </li>
  /// <li>
  /// DailyAutomaticBackupStartTime
  /// </li>
  /// <li>
  /// SelfManagedActiveDirectoryConfiguration
  /// </li>
  /// <li>
  /// StorageCapacity
  /// </li>
  /// <li>
  /// ThroughputCapacity
  /// </li>
  /// <li>
  /// WeeklyMaintenanceStartTime
  /// </li>
  /// </ul>
  /// For Amazon FSx for Lustre file systems, you can update the following
  /// properties:
  ///
  /// <ul>
  /// <li>
  /// AutoImportPolicy
  /// </li>
  /// <li>
  /// AutomaticBackupRetentionDays
  /// </li>
  /// <li>
  /// DailyAutomaticBackupStartTime
  /// </li>
  /// <li>
  /// StorageCapacity
  /// </li>
  /// <li>
  /// WeeklyMaintenanceStartTime
  /// </li>
  /// </ul>
  ///
  /// May throw [BadRequest].
  /// May throw [UnsupportedOperation].
  /// May throw [IncompatibleParameterError].
  /// May throw [InternalServerError].
  /// May throw [FileSystemNotFound].
  /// May throw [MissingFileSystemConfiguration].
  /// May throw [ServiceLimitExceeded].
  ///
  /// Parameter [fileSystemId] :
  /// Identifies the file system that you are updating.
  ///
  /// Parameter [clientRequestToken] :
  /// A string of up to 64 ASCII characters that Amazon FSx uses to ensure
  /// idempotent updates. This string is automatically filled on your behalf
  /// when you use the AWS Command Line Interface (AWS CLI) or an AWS SDK.
  ///
  /// Parameter [storageCapacity] :
  /// Use this parameter to increase the storage capacity of an Amazon FSx file
  /// system. Specifies the storage capacity target value, GiB, to increase the
  /// storage capacity for the file system that you're updating. You cannot make
  /// a storage capacity increase request if there is an existing storage
  /// capacity increase request in progress.
  ///
  /// For Windows file systems, the storage capacity target value must be at
  /// least 10 percent (%) greater than the current storage capacity value. In
  /// order to increase storage capacity, the file system must have at least 16
  /// MB/s of throughput capacity.
  ///
  /// For Lustre file systems, the storage capacity target value can be the
  /// following:
  ///
  /// <ul>
  /// <li>
  /// For <code>SCRATCH_2</code> and <code>PERSISTENT_1 SSD</code> deployment
  /// types, valid values are in multiples of 2400 GiB. The value must be
  /// greater than the current storage capacity.
  /// </li>
  /// <li>
  /// For <code>PERSISTENT HDD</code> file systems, valid values are multiples
  /// of 6000 GiB for 12 MB/s/TiB file systems and multiples of 1800 GiB for 40
  /// MB/s/TiB file systems. The values must be greater than the current storage
  /// capacity.
  /// </li>
  /// <li>
  /// For <code>SCRATCH_1</code> file systems, you cannot increase the storage
  /// capacity.
  /// </li>
  /// </ul>
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/fsx/latest/WindowsGuide/managing-storage-capacity.html">Managing
  /// storage capacity</a> in the <i>Amazon FSx for Windows File Server User
  /// Guide</i> and <a
  /// href="https://docs.aws.amazon.com/fsx/latest/LustreGuide/managing-storage-capacity.html">Managing
  /// storage and throughput capacity</a> in the <i>Amazon FSx for Lustre User
  /// Guide</i>.
  ///
  /// Parameter [windowsConfiguration] :
  /// The configuration updates for an Amazon FSx for Windows File Server file
  /// system.
  Future<UpdateFileSystemResponse> updateFileSystem({
    required String fileSystemId,
    String? clientRequestToken,
    UpdateFileSystemLustreConfiguration? lustreConfiguration,
    int? storageCapacity,
    UpdateFileSystemWindowsConfiguration? windowsConfiguration,
  }) async {
    ArgumentError.checkNotNull(fileSystemId, 'fileSystemId');
    _s.validateStringLength(
      'fileSystemId',
      fileSystemId,
      11,
      21,
      isRequired: true,
    );
    _s.validateStringLength(
      'clientRequestToken',
      clientRequestToken,
      1,
      63,
    );
    _s.validateNumRange(
      'storageCapacity',
      storageCapacity,
      0,
      2147483647,
    );
    final headers = <String, String>{
      'Content-Type': 'application/x-amz-json-1.1',
      'X-Amz-Target': 'AWSSimbaAPIService_v20180301.UpdateFileSystem'
    };
    final jsonResponse = await _protocol.send(
      method: 'POST',
      requestUri: '/',
      exceptionFnMap: _exceptionFns,
      // TODO queryParams
      headers: headers,
      payload: {
        'FileSystemId': fileSystemId,
        'ClientRequestToken':
            clientRequestToken ?? _s.generateIdempotencyToken(),
        if (lustreConfiguration != null)
          'LustreConfiguration': lustreConfiguration,
        if (storageCapacity != null) 'StorageCapacity': storageCapacity,
        if (windowsConfiguration != null)
          'WindowsConfiguration': windowsConfiguration,
      },
    );

    return UpdateFileSystemResponse.fromJson(jsonResponse.body);
  }
}

/// The Microsoft AD attributes of the Amazon FSx for Windows File Server file
/// system.
class ActiveDirectoryBackupAttributes {
  /// The ID of the AWS Managed Microsoft Active Directory instance to which the
  /// file system is joined.
  final String? activeDirectoryId;

  /// The fully qualified domain name of the self-managed AD directory.
  final String? domainName;

  ActiveDirectoryBackupAttributes({
    this.activeDirectoryId,
    this.domainName,
  });
  factory ActiveDirectoryBackupAttributes.fromJson(Map<String, dynamic> json) {
    return ActiveDirectoryBackupAttributes(
      activeDirectoryId: json['ActiveDirectoryId'] as String?,
      domainName: json['DomainName'] as String?,
    );
  }
}

/// Describes a specific Amazon FSx administrative action for the current
/// Windows or Lustre file system.
class AdministrativeAction {
  final AdministrativeActionType? administrativeActionType;
  final AdministrativeActionFailureDetails? failureDetails;

  /// Provides the percent complete of a <code>STORAGE_OPTIMIZATION</code>
  /// administrative action. Does not apply to any other administrative action
  /// type.
  final int? progressPercent;

  /// Time that the administrative action request was received.
  final DateTime? requestTime;

  /// Describes the status of the administrative action, as follows:
  ///
  /// <ul>
  /// <li>
  /// <code>FAILED</code> - Amazon FSx failed to process the administrative action
  /// successfully.
  /// </li>
  /// <li>
  /// <code>IN_PROGRESS</code> - Amazon FSx is processing the administrative
  /// action.
  /// </li>
  /// <li>
  /// <code>PENDING</code> - Amazon FSx is waiting to process the administrative
  /// action.
  /// </li>
  /// <li>
  /// <code>COMPLETED</code> - Amazon FSx has finished processing the
  /// administrative task.
  /// </li>
  /// <li>
  /// <code>UPDATED_OPTIMIZING</code> - For a storage capacity increase update,
  /// Amazon FSx has updated the file system with the new storage capacity, and is
  /// now performing the storage optimization process. For more information, see
  /// <a
  /// href="https://docs.aws.amazon.com/fsx/latest/WindowsGuide/managing-storage-capacity.html">Managing
  /// storage capacity</a> in the <i>Amazon FSx for Windows File Server User
  /// Guide</i> and <a
  /// href="https://docs.aws.amazon.com/fsx/latest/LustreGuide/managing-storage-capacity.html">Managing
  /// storage and throughput capacity</a> in the <i>Amazon FSx for Lustre User
  /// Guide</i>.
  /// </li>
  /// </ul>
  final Status? status;

  /// Describes the target value for the administration action, provided in the
  /// <code>UpdateFileSystem</code> operation. Returned for
  /// <code>FILE_SYSTEM_UPDATE</code> administrative actions.
  final FileSystem? targetFileSystemValues;

  AdministrativeAction({
    this.administrativeActionType,
    this.failureDetails,
    this.progressPercent,
    this.requestTime,
    this.status,
    this.targetFileSystemValues,
  });
  factory AdministrativeAction.fromJson(Map<String, dynamic> json) {
    return AdministrativeAction(
      administrativeActionType: (json['AdministrativeActionType'] as String?)
          ?.toAdministrativeActionType(),
      failureDetails: json['FailureDetails'] != null
          ? AdministrativeActionFailureDetails.fromJson(
              json['FailureDetails'] as Map<String, dynamic>)
          : null,
      progressPercent: json['ProgressPercent'] as int?,
      requestTime: timeStampFromJson(json['RequestTime']),
      status: (json['Status'] as String?)?.toStatus(),
      targetFileSystemValues: json['TargetFileSystemValues'] != null
          ? FileSystem.fromJson(
              json['TargetFileSystemValues'] as Map<String, dynamic>)
          : null,
    );
  }
}

/// Provides information about a failed administrative action.
class AdministrativeActionFailureDetails {
  /// Error message providing details about the failed administrative action.
  final String? message;

  AdministrativeActionFailureDetails({
    this.message,
  });
  factory AdministrativeActionFailureDetails.fromJson(
      Map<String, dynamic> json) {
    return AdministrativeActionFailureDetails(
      message: json['Message'] as String?,
    );
  }
}

/// Describes the type of administrative action, as follows:
///
/// <ul>
/// <li>
/// <code>FILE_SYSTEM_UPDATE</code> - A file system update administrative action
/// initiated by the user from the Amazon FSx console, API (UpdateFileSystem),
/// or CLI (update-file-system).
/// </li>
/// <li>
/// <code>STORAGE_OPTIMIZATION</code> - Once the <code>FILE_SYSTEM_UPDATE</code>
/// task to increase a file system's storage capacity completes successfully, a
/// <code>STORAGE_OPTIMIZATION</code> task starts.
///
/// <ul>
/// <li>
/// For Windows, storage optimization is the process of migrating the file
/// system data to the new, larger disks.
/// </li>
/// <li>
/// For Lustre, storage optimization consists of rebalancing the data across the
/// existing and newly added file servers.
/// </li>
/// </ul>
/// You can track the storage optimization progress using the
/// <code>ProgressPercent</code> property. When
/// <code>STORAGE_OPTIMIZATION</code> completes successfully, the parent
/// <code>FILE_SYSTEM_UPDATE</code> action status changes to
/// <code>COMPLETED</code>. For more information, see <a
/// href="https://docs.aws.amazon.com/fsx/latest/WindowsGuide/managing-storage-capacity.html">Managing
/// storage capacity</a> in the <i>Amazon FSx for Windows File Server User
/// Guide</i> and <a
/// href="https://docs.aws.amazon.com/fsx/latest/LustreGuide/managing-storage-capacity.html">Managing
/// storage and throughput capacity</a> in the <i>Amazon FSx for Lustre User
/// Guide</i>.
/// </li>
/// <li>
/// <code>FILE_SYSTEM_ALIAS_ASSOCIATION</code> - A file system update to
/// associate a new DNS alias with the file system. For more information, see .
/// </li>
/// <li>
/// <code>FILE_SYSTEM_ALIAS_DISASSOCIATION</code> - A file system update to
/// disassociate a DNS alias from the file system. For more information, see .
/// </li>
/// </ul>
enum AdministrativeActionType {
  fileSystemUpdate,
  storageOptimization,
  fileSystemAliasAssociation,
  fileSystemAliasDisassociation,
}

extension AdministrativeActionTypeValueExtension on AdministrativeActionType {
  String toValue() {
    switch (this) {
      case AdministrativeActionType.fileSystemUpdate:
        return 'FILE_SYSTEM_UPDATE';
      case AdministrativeActionType.storageOptimization:
        return 'STORAGE_OPTIMIZATION';
      case AdministrativeActionType.fileSystemAliasAssociation:
        return 'FILE_SYSTEM_ALIAS_ASSOCIATION';
      case AdministrativeActionType.fileSystemAliasDisassociation:
        return 'FILE_SYSTEM_ALIAS_DISASSOCIATION';
    }
  }
}

extension AdministrativeActionTypeFromString on String {
  AdministrativeActionType toAdministrativeActionType() {
    switch (this) {
      case 'FILE_SYSTEM_UPDATE':
        return AdministrativeActionType.fileSystemUpdate;
      case 'STORAGE_OPTIMIZATION':
        return AdministrativeActionType.storageOptimization;
      case 'FILE_SYSTEM_ALIAS_ASSOCIATION':
        return AdministrativeActionType.fileSystemAliasAssociation;
      case 'FILE_SYSTEM_ALIAS_DISASSOCIATION':
        return AdministrativeActionType.fileSystemAliasDisassociation;
    }
    throw Exception('$this is not known in enum AdministrativeActionType');
  }
}

/// A DNS alias that is associated with the file system. You can use a DNS alias
/// to access a file system using user-defined DNS names, in addition to the
/// default DNS name that Amazon FSx assigns to the file system. For more
/// information, see <a
/// href="https://docs.aws.amazon.com/fsx/latest/WindowsGuide/managing-dns-aliases.html">DNS
/// aliases</a> in the <i>FSx for Windows File Server User Guide</i>.
class Alias {
  /// Describes the state of the DNS alias.
  ///
  /// <ul>
  /// <li>
  /// AVAILABLE - The DNS alias is associated with an Amazon FSx file system.
  /// </li>
  /// <li>
  /// CREATING - Amazon FSx is creating the DNS alias and associating it with the
  /// file system.
  /// </li>
  /// <li>
  /// CREATE_FAILED - Amazon FSx was unable to associate the DNS alias with the
  /// file system.
  /// </li>
  /// <li>
  /// DELETING - Amazon FSx is disassociating the DNS alias from the file system
  /// and deleting it.
  /// </li>
  /// <li>
  /// DELETE_FAILED - Amazon FSx was unable to disassocate the DNS alias from the
  /// file system.
  /// </li>
  /// </ul>
  final AliasLifecycle? lifecycle;

  /// The name of the DNS alias. The alias name has to meet the following
  /// requirements:
  ///
  /// <ul>
  /// <li>
  /// Formatted as a fully-qualified domain name (FQDN),
  /// <code>hostname.domain</code>, for example,
  /// <code>accounting.example.com</code>.
  /// </li>
  /// <li>
  /// Can contain alphanumeric characters and the hyphen (-).
  /// </li>
  /// <li>
  /// Cannot start or end with a hyphen.
  /// </li>
  /// <li>
  /// Can start with a numeric.
  /// </li>
  /// </ul>
  /// For DNS names, Amazon FSx stores alphabetic characters as lowercase letters
  /// (a-z), regardless of how you specify them: as uppercase letters, lowercase
  /// letters, or the corresponding letters in escape codes.
  final String? name;

  Alias({
    this.lifecycle,
    this.name,
  });
  factory Alias.fromJson(Map<String, dynamic> json) {
    return Alias(
      lifecycle: (json['Lifecycle'] as String?)?.toAliasLifecycle(),
      name: json['Name'] as String?,
    );
  }
}

enum AliasLifecycle {
  available,
  creating,
  deleting,
  createFailed,
  deleteFailed,
}

extension AliasLifecycleValueExtension on AliasLifecycle {
  String toValue() {
    switch (this) {
      case AliasLifecycle.available:
        return 'AVAILABLE';
      case AliasLifecycle.creating:
        return 'CREATING';
      case AliasLifecycle.deleting:
        return 'DELETING';
      case AliasLifecycle.createFailed:
        return 'CREATE_FAILED';
      case AliasLifecycle.deleteFailed:
        return 'DELETE_FAILED';
    }
  }
}

extension AliasLifecycleFromString on String {
  AliasLifecycle toAliasLifecycle() {
    switch (this) {
      case 'AVAILABLE':
        return AliasLifecycle.available;
      case 'CREATING':
        return AliasLifecycle.creating;
      case 'DELETING':
        return AliasLifecycle.deleting;
      case 'CREATE_FAILED':
        return AliasLifecycle.createFailed;
      case 'DELETE_FAILED':
        return AliasLifecycle.deleteFailed;
    }
    throw Exception('$this is not known in enum AliasLifecycle');
  }
}

/// The system generated response showing the DNS aliases that Amazon FSx is
/// attempting to associate with the file system. Use the API operation to
/// monitor the status of the aliases Amazon FSx is associating with the file
/// system. It can take up to 2.5 minutes for the alias status to change from
/// <code>CREATING</code> to <code>AVAILABLE</code>.
class AssociateFileSystemAliasesResponse {
  /// An array of the DNS aliases that Amazon FSx is associating with the file
  /// system.
  final List<Alias>? aliases;

  AssociateFileSystemAliasesResponse({
    this.aliases,
  });
  factory AssociateFileSystemAliasesResponse.fromJson(
      Map<String, dynamic> json) {
    return AssociateFileSystemAliasesResponse(
      aliases: (json['Aliases'] as List?)
          ?.whereNotNull()
          .map((e) => Alias.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

enum AutoImportPolicyType {
  none,
  $new,
  newChanged,
}

extension AutoImportPolicyTypeValueExtension on AutoImportPolicyType {
  String toValue() {
    switch (this) {
      case AutoImportPolicyType.none:
        return 'NONE';
      case AutoImportPolicyType.$new:
        return 'NEW';
      case AutoImportPolicyType.newChanged:
        return 'NEW_CHANGED';
    }
  }
}

extension AutoImportPolicyTypeFromString on String {
  AutoImportPolicyType toAutoImportPolicyType() {
    switch (this) {
      case 'NONE':
        return AutoImportPolicyType.none;
      case 'NEW':
        return AutoImportPolicyType.$new;
      case 'NEW_CHANGED':
        return AutoImportPolicyType.newChanged;
    }
    throw Exception('$this is not known in enum AutoImportPolicyType');
  }
}

/// A backup of an Amazon FSx file system. For more information see:
///
/// <ul>
/// <li>
/// <a
/// href="https://docs.aws.amazon.com/fsx/latest/WindowsGuide/using-backups.html">Working
/// with backups for Windows file systems</a>
/// </li>
/// <li>
/// <a
/// href="https://docs.aws.amazon.com/fsx/latest/LustreGuide/using-backups-fsx.html">Working
/// with backups for Lustre file systems</a>
/// </li>
/// </ul>
class Backup {
  /// The ID of the backup.
  final String backupId;

  /// The time when a particular backup was created.
  final DateTime creationTime;

  /// Metadata of the file system associated with the backup. This metadata is
  /// persisted even if the file system is deleted.
  final FileSystem fileSystem;

  /// The lifecycle status of the backup.
  ///
  /// <ul>
  /// <li>
  /// <code>AVAILABLE</code> - The backup is fully available.
  /// </li>
  /// <li>
  /// <code>PENDING</code> - For user-initiated backups on Lustre file systems
  /// only; Amazon FSx has not started creating the backup.
  /// </li>
  /// <li>
  /// <code>CREATING</code> - Amazon FSx is creating the backup.
  /// </li>
  /// <li>
  /// <code>TRANSFERRING</code> - For user-initiated backups on Lustre file
  /// systems only; Amazon FSx is transferring the backup to S3.
  /// </li>
  /// <li>
  /// <code>DELETED</code> - Amazon FSx deleted the backup and it is no longer
  /// available.
  /// </li>
  /// <li>
  /// <code>FAILED</code> - Amazon FSx could not complete the backup.
  /// </li>
  /// </ul>
  final BackupLifecycle lifecycle;

  /// The type of the file system backup.
  final BackupType type;

  /// The configuration of the self-managed Microsoft Active Directory (AD) to
  /// which the Windows File Server instance is joined.
  final ActiveDirectoryBackupAttributes? directoryInformation;

  /// Details explaining any failures that occur when creating a backup.
  final BackupFailureDetails? failureDetails;

  /// The ID of the AWS Key Management Service (AWS KMS) key used to encrypt the
  /// backup of the Amazon FSx file system's data at rest.
  final String? kmsKeyId;
  final int? progressPercent;

  /// The Amazon Resource Name (ARN) for the backup resource.
  final String? resourceARN;

  /// Tags associated with a particular file system.
  final List<Tag>? tags;

  Backup({
    required this.backupId,
    required this.creationTime,
    required this.fileSystem,
    required this.lifecycle,
    required this.type,
    this.directoryInformation,
    this.failureDetails,
    this.kmsKeyId,
    this.progressPercent,
    this.resourceARN,
    this.tags,
  });
  factory Backup.fromJson(Map<String, dynamic> json) {
    return Backup(
      backupId: json['BackupId'] as String,
      creationTime:
          nonNullableTimeStampFromJson(json['CreationTime'] as Object),
      fileSystem:
          FileSystem.fromJson(json['FileSystem'] as Map<String, dynamic>),
      lifecycle: (json['Lifecycle'] as String).toBackupLifecycle(),
      type: (json['Type'] as String).toBackupType(),
      directoryInformation: json['DirectoryInformation'] != null
          ? ActiveDirectoryBackupAttributes.fromJson(
              json['DirectoryInformation'] as Map<String, dynamic>)
          : null,
      failureDetails: json['FailureDetails'] != null
          ? BackupFailureDetails.fromJson(
              json['FailureDetails'] as Map<String, dynamic>)
          : null,
      kmsKeyId: json['KmsKeyId'] as String?,
      progressPercent: json['ProgressPercent'] as int?,
      resourceARN: json['ResourceARN'] as String?,
      tags: (json['Tags'] as List?)
          ?.whereNotNull()
          .map((e) => Tag.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// If backup creation fails, this structure contains the details of that
/// failure.
class BackupFailureDetails {
  /// A message describing the backup creation failure.
  final String? message;

  BackupFailureDetails({
    this.message,
  });
  factory BackupFailureDetails.fromJson(Map<String, dynamic> json) {
    return BackupFailureDetails(
      message: json['Message'] as String?,
    );
  }
}

/// The lifecycle status of the backup.
///
/// <ul>
/// <li>
/// <code>AVAILABLE</code> - The backup is fully available.
/// </li>
/// <li>
/// <code>PENDING</code> - For user-initiated backups on Lustre file systems
/// only; Amazon FSx has not started creating the backup.
/// </li>
/// <li>
/// <code>CREATING</code> - Amazon FSx is creating the new user-intiated backup
/// </li>
/// <li>
/// <code>TRANSFERRING</code> - For user-initiated backups on Lustre file
/// systems only; Amazon FSx is backing up the file system.
/// </li>
/// <li>
/// <code>DELETED</code> - Amazon FSx deleted the backup and it is no longer
/// available.
/// </li>
/// <li>
/// <code>FAILED</code> - Amazon FSx could not complete the backup.
/// </li>
/// </ul>
enum BackupLifecycle {
  available,
  creating,
  transferring,
  deleted,
  failed,
  pending,
}

extension BackupLifecycleValueExtension on BackupLifecycle {
  String toValue() {
    switch (this) {
      case BackupLifecycle.available:
        return 'AVAILABLE';
      case BackupLifecycle.creating:
        return 'CREATING';
      case BackupLifecycle.transferring:
        return 'TRANSFERRING';
      case BackupLifecycle.deleted:
        return 'DELETED';
      case BackupLifecycle.failed:
        return 'FAILED';
      case BackupLifecycle.pending:
        return 'PENDING';
    }
  }
}

extension BackupLifecycleFromString on String {
  BackupLifecycle toBackupLifecycle() {
    switch (this) {
      case 'AVAILABLE':
        return BackupLifecycle.available;
      case 'CREATING':
        return BackupLifecycle.creating;
      case 'TRANSFERRING':
        return BackupLifecycle.transferring;
      case 'DELETED':
        return BackupLifecycle.deleted;
      case 'FAILED':
        return BackupLifecycle.failed;
      case 'PENDING':
        return BackupLifecycle.pending;
    }
    throw Exception('$this is not known in enum BackupLifecycle');
  }
}

/// The type of the backup.
enum BackupType {
  automatic,
  userInitiated,
  awsBackup,
}

extension BackupTypeValueExtension on BackupType {
  String toValue() {
    switch (this) {
      case BackupType.automatic:
        return 'AUTOMATIC';
      case BackupType.userInitiated:
        return 'USER_INITIATED';
      case BackupType.awsBackup:
        return 'AWS_BACKUP';
    }
  }
}

extension BackupTypeFromString on String {
  BackupType toBackupType() {
    switch (this) {
      case 'AUTOMATIC':
        return BackupType.automatic;
      case 'USER_INITIATED':
        return BackupType.userInitiated;
      case 'AWS_BACKUP':
        return BackupType.awsBackup;
    }
    throw Exception('$this is not known in enum BackupType');
  }
}

class CancelDataRepositoryTaskResponse {
  /// The lifecycle status of the data repository task, as follows:
  ///
  /// <ul>
  /// <li>
  /// <code>PENDING</code> - Amazon FSx has not started the task.
  /// </li>
  /// <li>
  /// <code>EXECUTING</code> - Amazon FSx is processing the task.
  /// </li>
  /// <li>
  /// <code>FAILED</code> - Amazon FSx was not able to complete the task. For
  /// example, there may be files the task failed to process. The
  /// <a>DataRepositoryTaskFailureDetails</a> property provides more information
  /// about task failures.
  /// </li>
  /// <li>
  /// <code>SUCCEEDED</code> - FSx completed the task successfully.
  /// </li>
  /// <li>
  /// <code>CANCELED</code> - Amazon FSx canceled the task and it did not
  /// complete.
  /// </li>
  /// <li>
  /// <code>CANCELING</code> - FSx is in process of canceling the task.
  /// </li>
  /// </ul>
  final DataRepositoryTaskLifecycle? lifecycle;

  /// The ID of the task being canceled.
  final String? taskId;

  CancelDataRepositoryTaskResponse({
    this.lifecycle,
    this.taskId,
  });
  factory CancelDataRepositoryTaskResponse.fromJson(Map<String, dynamic> json) {
    return CancelDataRepositoryTaskResponse(
      lifecycle:
          (json['Lifecycle'] as String?)?.toDataRepositoryTaskLifecycle(),
      taskId: json['TaskId'] as String?,
    );
  }
}

/// Provides a report detailing the data repository task results of the files
/// processed that match the criteria specified in the report <code>Scope</code>
/// parameter. FSx delivers the report to the file system's linked data
/// repository in Amazon S3, using the path specified in the report
/// <code>Path</code> parameter. You can specify whether or not a report gets
/// generated for a task using the <code>Enabled</code> parameter.
class CompletionReport {
  /// Set <code>Enabled</code> to <code>True</code> to generate a
  /// <code>CompletionReport</code> when the task completes. If set to
  /// <code>true</code>, then you need to provide a report <code>Scope</code>,
  /// <code>Path</code>, and <code>Format</code>. Set <code>Enabled</code> to
  /// <code>False</code> if you do not want a <code>CompletionReport</code>
  /// generated when the task completes.
  final bool enabled;

  /// Required if <code>Enabled</code> is set to <code>true</code>. Specifies the
  /// format of the <code>CompletionReport</code>.
  /// <code>REPORT_CSV_20191124</code> is the only format currently supported.
  /// When <code>Format</code> is set to <code>REPORT_CSV_20191124</code>, the
  /// <code>CompletionReport</code> is provided in CSV format, and is delivered to
  /// <code>{path}/task-{id}/failures.csv</code>.
  final ReportFormat? format;

  /// Required if <code>Enabled</code> is set to <code>true</code>. Specifies the
  /// location of the report on the file system's linked S3 data repository. An
  /// absolute path that defines where the completion report will be stored in the
  /// destination location. The <code>Path</code> you provide must be located
  /// within the file system’s ExportPath. An example <code>Path</code> value is
  /// "s3://myBucket/myExportPath/optionalPrefix". The report provides the
  /// following information for each file in the report: FilePath, FileStatus, and
  /// ErrorCode. To learn more about a file system's <code>ExportPath</code>, see
  /// .
  final String? path;

  /// Required if <code>Enabled</code> is set to <code>true</code>. Specifies the
  /// scope of the <code>CompletionReport</code>; <code>FAILED_FILES_ONLY</code>
  /// is the only scope currently supported. When <code>Scope</code> is set to
  /// <code>FAILED_FILES_ONLY</code>, the <code>CompletionReport</code> only
  /// contains information about files that the data repository task failed to
  /// process.
  final ReportScope? scope;

  CompletionReport({
    required this.enabled,
    this.format,
    this.path,
    this.scope,
  });
  factory CompletionReport.fromJson(Map<String, dynamic> json) {
    return CompletionReport(
      enabled: json['Enabled'] as bool,
      format: (json['Format'] as String?)?.toReportFormat(),
      path: json['Path'] as String?,
      scope: (json['Scope'] as String?)?.toReportScope(),
    );
  }

  Map<String, dynamic> toJson() {
    final enabled = this.enabled;
    final format = this.format;
    final path = this.path;
    final scope = this.scope;
    return {
      'Enabled': enabled,
      if (format != null) 'Format': format.toValue(),
      if (path != null) 'Path': path,
      if (scope != null) 'Scope': scope.toValue(),
    };
  }
}

/// The response object for the <code>CreateBackup</code> operation.
class CreateBackupResponse {
  /// A description of the backup.
  final Backup? backup;

  CreateBackupResponse({
    this.backup,
  });
  factory CreateBackupResponse.fromJson(Map<String, dynamic> json) {
    return CreateBackupResponse(
      backup: json['Backup'] != null
          ? Backup.fromJson(json['Backup'] as Map<String, dynamic>)
          : null,
    );
  }
}

class CreateDataRepositoryTaskResponse {
  /// The description of the data repository task that you just created.
  final DataRepositoryTask? dataRepositoryTask;

  CreateDataRepositoryTaskResponse({
    this.dataRepositoryTask,
  });
  factory CreateDataRepositoryTaskResponse.fromJson(Map<String, dynamic> json) {
    return CreateDataRepositoryTaskResponse(
      dataRepositoryTask: json['DataRepositoryTask'] != null
          ? DataRepositoryTask.fromJson(
              json['DataRepositoryTask'] as Map<String, dynamic>)
          : null,
    );
  }
}

/// The response object for the <code>CreateFileSystemFromBackup</code>
/// operation.
class CreateFileSystemFromBackupResponse {
  /// A description of the file system.
  final FileSystem? fileSystem;

  CreateFileSystemFromBackupResponse({
    this.fileSystem,
  });
  factory CreateFileSystemFromBackupResponse.fromJson(
      Map<String, dynamic> json) {
    return CreateFileSystemFromBackupResponse(
      fileSystem: json['FileSystem'] != null
          ? FileSystem.fromJson(json['FileSystem'] as Map<String, dynamic>)
          : null,
    );
  }
}

/// The Lustre configuration for the file system being created.
class CreateFileSystemLustreConfiguration {
  /// (Optional) When you create your file system, your existing S3 objects appear
  /// as file and directory listings. Use this property to choose how Amazon FSx
  /// keeps your file and directory listings up to date as you add or modify
  /// objects in your linked S3 bucket. <code>AutoImportPolicy</code> can have the
  /// following values:
  ///
  /// <ul>
  /// <li>
  /// <code>NONE</code> - (Default) AutoImport is off. Amazon FSx only updates
  /// file and directory listings from the linked S3 bucket when the file system
  /// is created. FSx does not update file and directory listings for any new or
  /// changed objects after choosing this option.
  /// </li>
  /// <li>
  /// <code>NEW</code> - AutoImport is on. Amazon FSx automatically imports
  /// directory listings of any new objects added to the linked S3 bucket that do
  /// not currently exist in the FSx file system.
  /// </li>
  /// <li>
  /// <code>NEW_CHANGED</code> - AutoImport is on. Amazon FSx automatically
  /// imports file and directory listings of any new objects added to the S3
  /// bucket and any existing objects that are changed in the S3 bucket after you
  /// choose this option.
  /// </li>
  /// </ul>
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/fsx/latest/LustreGuide/autoimport-data-repo.html">Automatically
  /// import updates from your S3 bucket</a>.
  final AutoImportPolicyType? autoImportPolicy;
  final int? automaticBackupRetentionDays;

  /// (Optional) Not available to use with file systems that are linked to a data
  /// repository. A boolean flag indicating whether tags for the file system
  /// should be copied to backups. The default value is false. If it's set to
  /// true, all file system tags are copied to all automatic and user-initiated
  /// backups when the user doesn't specify any backup-specific tags. If this
  /// value is true, and you specify one or more backup tags, only the specified
  /// tags are copied to backups. If you specify one or more tags when creating a
  /// user-initiated backup, no tags are copied from the file system, regardless
  /// of this value.
  ///
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/fsx/latest/LustreGuide/using-backups-fsx.html">Working
  /// with backups</a>.
  final bool? copyTagsToBackups;
  final String? dailyAutomaticBackupStartTime;

  /// Choose <code>SCRATCH_1</code> and <code>SCRATCH_2</code> deployment types
  /// when you need temporary storage and shorter-term processing of data. The
  /// <code>SCRATCH_2</code> deployment type provides in-transit encryption of
  /// data and higher burst throughput capacity than <code>SCRATCH_1</code>.
  ///
  /// Choose <code>PERSISTENT_1</code> deployment type for longer-term storage and
  /// workloads and encryption of data in transit. To learn more about deployment
  /// types, see <a
  /// href="https://docs.aws.amazon.com/fsx/latest/LustreGuide/lustre-deployment-types.html">
  /// FSx for Lustre Deployment Options</a>.
  ///
  /// Encryption of data in-transit is automatically enabled when you access a
  /// <code>SCRATCH_2</code> or <code>PERSISTENT_1</code> file system from Amazon
  /// EC2 instances that <a
  /// href="https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/data-
  /// protection.html">support this feature</a>. (Default =
  /// <code>SCRATCH_1</code>)
  ///
  /// Encryption of data in-transit for <code>SCRATCH_2</code> and
  /// <code>PERSISTENT_1</code> deployment types is supported when accessed from
  /// supported instance types in supported AWS Regions. To learn more, <a
  /// href="https://docs.aws.amazon.com/fsx/latest/LustreGuide/encryption-in-transit-fsxl.html">Encrypting
  /// Data in Transit</a>.
  final LustreDeploymentType? deploymentType;

  /// The type of drive cache used by PERSISTENT_1 file systems that are
  /// provisioned with HDD storage devices. This parameter is required when
  /// storage type is HDD. Set to <code>READ</code>, improve the performance for
  /// frequently accessed files and allows 20% of the total storage capacity of
  /// the file system to be cached.
  ///
  /// This parameter is required when <code>StorageType</code> is set to HDD.
  final DriveCacheType? driveCacheType;

  /// (Optional) The path in Amazon S3 where the root of your Amazon FSx file
  /// system is exported. The path must use the same Amazon S3 bucket as specified
  /// in ImportPath. You can provide an optional prefix to which new and changed
  /// data is to be exported from your Amazon FSx for Lustre file system. If an
  /// <code>ExportPath</code> value is not provided, Amazon FSx sets a default
  /// export path, <code>s3://import-bucket/FSxLustre[creation-timestamp]</code>.
  /// The timestamp is in UTC format, for example
  /// <code>s3://import-bucket/FSxLustre20181105T222312Z</code>.
  ///
  /// The Amazon S3 export bucket must be the same as the import bucket specified
  /// by <code>ImportPath</code>. If you only specify a bucket name, such as
  /// <code>s3://import-bucket</code>, you get a 1:1 mapping of file system
  /// objects to S3 bucket objects. This mapping means that the input data in S3
  /// is overwritten on export. If you provide a custom prefix in the export path,
  /// such as <code>s3://import-bucket/[custom-optional-prefix]</code>, Amazon FSx
  /// exports the contents of your file system to that export prefix in the Amazon
  /// S3 bucket.
  final String? exportPath;

  /// (Optional) The path to the Amazon S3 bucket (including the optional prefix)
  /// that you're using as the data repository for your Amazon FSx for Lustre file
  /// system. The root of your FSx for Lustre file system will be mapped to the
  /// root of the Amazon S3 bucket you select. An example is
  /// <code>s3://import-bucket/optional-prefix</code>. If you specify a prefix
  /// after the Amazon S3 bucket name, only object keys with that prefix are
  /// loaded into the file system.
  final String? importPath;

  /// (Optional) For files imported from a data repository, this value determines
  /// the stripe count and maximum amount of data per file (in MiB) stored on a
  /// single physical disk. The maximum number of disks that a single file can be
  /// striped across is limited by the total number of disks that make up the file
  /// system.
  ///
  /// The default chunk size is 1,024 MiB (1 GiB) and can go as high as 512,000
  /// MiB (500 GiB). Amazon S3 objects have a maximum size of 5 TB.
  final int? importedFileChunkSize;

  /// Required for the <code>PERSISTENT_1</code> deployment type, describes the
  /// amount of read and write throughput for each 1 tebibyte of storage, in
  /// MB/s/TiB. File system throughput capacity is calculated by multiplying ﬁle
  /// system storage capacity (TiB) by the PerUnitStorageThroughput (MB/s/TiB).
  /// For a 2.4 TiB ﬁle system, provisioning 50 MB/s/TiB of
  /// PerUnitStorageThroughput yields 120 MB/s of ﬁle system throughput. You pay
  /// for the amount of throughput that you provision.
  ///
  /// Valid values for SSD storage: 50, 100, 200. Valid values for HDD storage:
  /// 12, 40.
  final int? perUnitStorageThroughput;

  /// (Optional) The preferred start time to perform weekly maintenance, formatted
  /// d:HH:MM in the UTC time zone, where d is the weekday number, from 1 through
  /// 7, beginning with Monday and ending with Sunday.
  final String? weeklyMaintenanceStartTime;

  CreateFileSystemLustreConfiguration({
    this.autoImportPolicy,
    this.automaticBackupRetentionDays,
    this.copyTagsToBackups,
    this.dailyAutomaticBackupStartTime,
    this.deploymentType,
    this.driveCacheType,
    this.exportPath,
    this.importPath,
    this.importedFileChunkSize,
    this.perUnitStorageThroughput,
    this.weeklyMaintenanceStartTime,
  });
  Map<String, dynamic> toJson() {
    final autoImportPolicy = this.autoImportPolicy;
    final automaticBackupRetentionDays = this.automaticBackupRetentionDays;
    final copyTagsToBackups = this.copyTagsToBackups;
    final dailyAutomaticBackupStartTime = this.dailyAutomaticBackupStartTime;
    final deploymentType = this.deploymentType;
    final driveCacheType = this.driveCacheType;
    final exportPath = this.exportPath;
    final importPath = this.importPath;
    final importedFileChunkSize = this.importedFileChunkSize;
    final perUnitStorageThroughput = this.perUnitStorageThroughput;
    final weeklyMaintenanceStartTime = this.weeklyMaintenanceStartTime;
    return {
      if (autoImportPolicy != null)
        'AutoImportPolicy': autoImportPolicy.toValue(),
      if (automaticBackupRetentionDays != null)
        'AutomaticBackupRetentionDays': automaticBackupRetentionDays,
      if (copyTagsToBackups != null) 'CopyTagsToBackups': copyTagsToBackups,
      if (dailyAutomaticBackupStartTime != null)
        'DailyAutomaticBackupStartTime': dailyAutomaticBackupStartTime,
      if (deploymentType != null) 'DeploymentType': deploymentType.toValue(),
      if (driveCacheType != null) 'DriveCacheType': driveCacheType.toValue(),
      if (exportPath != null) 'ExportPath': exportPath,
      if (importPath != null) 'ImportPath': importPath,
      if (importedFileChunkSize != null)
        'ImportedFileChunkSize': importedFileChunkSize,
      if (perUnitStorageThroughput != null)
        'PerUnitStorageThroughput': perUnitStorageThroughput,
      if (weeklyMaintenanceStartTime != null)
        'WeeklyMaintenanceStartTime': weeklyMaintenanceStartTime,
    };
  }
}

/// The response object returned after the file system is created.
class CreateFileSystemResponse {
  /// The configuration of the file system that was created.
  final FileSystem? fileSystem;

  CreateFileSystemResponse({
    this.fileSystem,
  });
  factory CreateFileSystemResponse.fromJson(Map<String, dynamic> json) {
    return CreateFileSystemResponse(
      fileSystem: json['FileSystem'] != null
          ? FileSystem.fromJson(json['FileSystem'] as Map<String, dynamic>)
          : null,
    );
  }
}

/// The configuration object for the Microsoft Windows file system used in
/// <code>CreateFileSystem</code> and <code>CreateFileSystemFromBackup</code>
/// operations.
class CreateFileSystemWindowsConfiguration {
  /// The throughput of an Amazon FSx file system, measured in megabytes per
  /// second, in 2 to the <i>n</i>th increments, between 2^3 (8) and 2^11 (2048).
  final int throughputCapacity;

  /// The ID for an existing AWS Managed Microsoft Active Directory (AD) instance
  /// that the file system should join when it's created.
  final String? activeDirectoryId;

  /// An array of one or more DNS alias names that you want to associate with the
  /// Amazon FSx file system. Aliases allow you to use existing DNS names to
  /// access the data in your Amazon FSx file system. You can associate up to 50
  /// aliases with a file system at any time. You can associate additional DNS
  /// aliases after you create the file system using the
  /// AssociateFileSystemAliases operation. You can remove DNS aliases from the
  /// file system after it is created using the DisassociateFileSystemAliases
  /// operation. You only need to specify the alias name in the request payload.
  ///
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/fsx/latest/WindowsGuide/managing-dns-aliases.html">Working
  /// with DNS Aliases</a> and <a
  /// href="https://docs.aws.amazon.com/fsx/latest/WindowsGuide/walkthrough05-file-system-custom-CNAME.html">Walkthrough
  /// 5: Using DNS aliases to access your file system</a>, including additional
  /// steps you must take to be able to access your file system using a DNS alias.
  ///
  /// An alias name has to meet the following requirements:
  ///
  /// <ul>
  /// <li>
  /// Formatted as a fully-qualified domain name (FQDN),
  /// <code>hostname.domain</code>, for example,
  /// <code>accounting.example.com</code>.
  /// </li>
  /// <li>
  /// Can contain alphanumeric characters and the hyphen (-).
  /// </li>
  /// <li>
  /// Cannot start or end with a hyphen.
  /// </li>
  /// <li>
  /// Can start with a numeric.
  /// </li>
  /// </ul>
  /// For DNS alias names, Amazon FSx stores alphabetic characters as lowercase
  /// letters (a-z), regardless of how you specify them: as uppercase letters,
  /// lowercase letters, or the corresponding letters in escape codes.
  final List<String>? aliases;

  /// The number of days to retain automatic backups. The default is to retain
  /// backups for 7 days. Setting this value to 0 disables the creation of
  /// automatic backups. The maximum retention period for backups is 90 days.
  final int? automaticBackupRetentionDays;

  /// A boolean flag indicating whether tags for the file system should be copied
  /// to backups. This value defaults to false. If it's set to true, all tags for
  /// the file system are copied to all automatic and user-initiated backups where
  /// the user doesn't specify tags. If this value is true, and you specify one or
  /// more tags, only the specified tags are copied to backups. If you specify one
  /// or more tags when creating a user-initiated backup, no tags are copied from
  /// the file system, regardless of this value.
  final bool? copyTagsToBackups;

  /// The preferred time to take daily automatic backups, formatted HH:MM in the
  /// UTC time zone.
  final String? dailyAutomaticBackupStartTime;

  /// Specifies the file system deployment type, valid values are the following:
  ///
  /// <ul>
  /// <li>
  /// <code>MULTI_AZ_1</code> - Deploys a high availability file system that is
  /// configured for Multi-AZ redundancy to tolerate temporary Availability Zone
  /// (AZ) unavailability. You can only deploy a Multi-AZ file system in AWS
  /// Regions that have a minimum of three Availability Zones. Also supports HDD
  /// storage type
  /// </li>
  /// <li>
  /// <code>SINGLE_AZ_1</code> - (Default) Choose to deploy a file system that is
  /// configured for single AZ redundancy.
  /// </li>
  /// <li>
  /// <code>SINGLE_AZ_2</code> - The latest generation Single AZ file system.
  /// Specifies a file system that is configured for single AZ redundancy and
  /// supports HDD storage type.
  /// </li>
  /// </ul>
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/fsx/latest/WindowsGuide/high-availability-multiAZ.html">
  /// Availability and Durability: Single-AZ and Multi-AZ File Systems</a>.
  final WindowsDeploymentType? deploymentType;

  /// Required when <code>DeploymentType</code> is set to <code>MULTI_AZ_1</code>.
  /// This specifies the subnet in which you want the preferred file server to be
  /// located. For in-AWS applications, we recommend that you launch your clients
  /// in the same Availability Zone (AZ) as your preferred file server to reduce
  /// cross-AZ data transfer costs and minimize latency.
  final String? preferredSubnetId;
  final SelfManagedActiveDirectoryConfiguration?
      selfManagedActiveDirectoryConfiguration;

  /// The preferred start time to perform weekly maintenance, formatted d:HH:MM in
  /// the UTC time zone, where d is the weekday number, from 1 through 7,
  /// beginning with Monday and ending with Sunday.
  final String? weeklyMaintenanceStartTime;

  CreateFileSystemWindowsConfiguration({
    required this.throughputCapacity,
    this.activeDirectoryId,
    this.aliases,
    this.automaticBackupRetentionDays,
    this.copyTagsToBackups,
    this.dailyAutomaticBackupStartTime,
    this.deploymentType,
    this.preferredSubnetId,
    this.selfManagedActiveDirectoryConfiguration,
    this.weeklyMaintenanceStartTime,
  });
  Map<String, dynamic> toJson() {
    final throughputCapacity = this.throughputCapacity;
    final activeDirectoryId = this.activeDirectoryId;
    final aliases = this.aliases;
    final automaticBackupRetentionDays = this.automaticBackupRetentionDays;
    final copyTagsToBackups = this.copyTagsToBackups;
    final dailyAutomaticBackupStartTime = this.dailyAutomaticBackupStartTime;
    final deploymentType = this.deploymentType;
    final preferredSubnetId = this.preferredSubnetId;
    final selfManagedActiveDirectoryConfiguration =
        this.selfManagedActiveDirectoryConfiguration;
    final weeklyMaintenanceStartTime = this.weeklyMaintenanceStartTime;
    return {
      'ThroughputCapacity': throughputCapacity,
      if (activeDirectoryId != null) 'ActiveDirectoryId': activeDirectoryId,
      if (aliases != null) 'Aliases': aliases,
      if (automaticBackupRetentionDays != null)
        'AutomaticBackupRetentionDays': automaticBackupRetentionDays,
      if (copyTagsToBackups != null) 'CopyTagsToBackups': copyTagsToBackups,
      if (dailyAutomaticBackupStartTime != null)
        'DailyAutomaticBackupStartTime': dailyAutomaticBackupStartTime,
      if (deploymentType != null) 'DeploymentType': deploymentType.toValue(),
      if (preferredSubnetId != null) 'PreferredSubnetId': preferredSubnetId,
      if (selfManagedActiveDirectoryConfiguration != null)
        'SelfManagedActiveDirectoryConfiguration':
            selfManagedActiveDirectoryConfiguration,
      if (weeklyMaintenanceStartTime != null)
        'WeeklyMaintenanceStartTime': weeklyMaintenanceStartTime,
    };
  }
}

/// The data repository configuration object for Lustre file systems returned in
/// the response of the <code>CreateFileSystem</code> operation.
class DataRepositoryConfiguration {
  /// Describes the file system's linked S3 data repository's
  /// <code>AutoImportPolicy</code>. The AutoImportPolicy configures how Amazon
  /// FSx keeps your file and directory listings up to date as you add or modify
  /// objects in your linked S3 bucket. <code>AutoImportPolicy</code> can have the
  /// following values:
  ///
  /// <ul>
  /// <li>
  /// <code>NONE</code> - (Default) AutoImport is off. Amazon FSx only updates
  /// file and directory listings from the linked S3 bucket when the file system
  /// is created. FSx does not update file and directory listings for any new or
  /// changed objects after choosing this option.
  /// </li>
  /// <li>
  /// <code>NEW</code> - AutoImport is on. Amazon FSx automatically imports
  /// directory listings of any new objects added to the linked S3 bucket that do
  /// not currently exist in the FSx file system.
  /// </li>
  /// <li>
  /// <code>NEW_CHANGED</code> - AutoImport is on. Amazon FSx automatically
  /// imports file and directory listings of any new objects added to the S3
  /// bucket and any existing objects that are changed in the S3 bucket after you
  /// choose this option.
  /// </li>
  /// </ul>
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/fsx/latest/LustreGuide/autoimport-data-repo.html">Automatically
  /// import updates from your S3 bucket</a>.
  final AutoImportPolicyType? autoImportPolicy;

  /// The export path to the Amazon S3 bucket (and prefix) that you are using to
  /// store new and changed Lustre file system files in S3.
  final String? exportPath;
  final DataRepositoryFailureDetails? failureDetails;

  /// The import path to the Amazon S3 bucket (and optional prefix) that you're
  /// using as the data repository for your FSx for Lustre file system, for
  /// example <code>s3://import-bucket/optional-prefix</code>. If a prefix is
  /// specified after the Amazon S3 bucket name, only object keys with that prefix
  /// are loaded into the file system.
  final String? importPath;

  /// For files imported from a data repository, this value determines the stripe
  /// count and maximum amount of data per file (in MiB) stored on a single
  /// physical disk. The maximum number of disks that a single file can be striped
  /// across is limited by the total number of disks that make up the file system.
  ///
  /// The default chunk size is 1,024 MiB (1 GiB) and can go as high as 512,000
  /// MiB (500 GiB). Amazon S3 objects have a maximum size of 5 TB.
  final int? importedFileChunkSize;

  /// Describes the state of the file system's S3 durable data repository, if it
  /// is configured with an S3 repository. The lifecycle can have the following
  /// values:
  ///
  /// <ul>
  /// <li>
  /// <code>CREATING</code> - The data repository configuration between the FSx
  /// file system and the linked S3 data repository is being created. The data
  /// repository is unavailable.
  /// </li>
  /// <li>
  /// <code>AVAILABLE</code> - The data repository is available for use.
  /// </li>
  /// <li>
  /// <code>MISCONFIGURED</code> - Amazon FSx cannot automatically import updates
  /// from the S3 bucket until the data repository configuration is corrected. For
  /// more information, see <a
  /// href="https://docs.aws.amazon.com/fsx/latest/LustreGuide/troubleshooting.html#troubleshooting-misconfigured-data-repository">Troubleshooting
  /// a Misconfigured linked S3 bucket</a>.
  /// </li>
  /// <li>
  /// <code>UPDATING</code> - The data repository is undergoing a customer
  /// initiated update and availability may be impacted.
  /// </li>
  /// </ul>
  final DataRepositoryLifecycle? lifecycle;

  DataRepositoryConfiguration({
    this.autoImportPolicy,
    this.exportPath,
    this.failureDetails,
    this.importPath,
    this.importedFileChunkSize,
    this.lifecycle,
  });
  factory DataRepositoryConfiguration.fromJson(Map<String, dynamic> json) {
    return DataRepositoryConfiguration(
      autoImportPolicy:
          (json['AutoImportPolicy'] as String?)?.toAutoImportPolicyType(),
      exportPath: json['ExportPath'] as String?,
      failureDetails: json['FailureDetails'] != null
          ? DataRepositoryFailureDetails.fromJson(
              json['FailureDetails'] as Map<String, dynamic>)
          : null,
      importPath: json['ImportPath'] as String?,
      importedFileChunkSize: json['ImportedFileChunkSize'] as int?,
      lifecycle: (json['Lifecycle'] as String?)?.toDataRepositoryLifecycle(),
    );
  }
}

/// Provides detailed information about the data respository if its
/// <code>Lifecycle</code> is set to <code>MISCONFIGURED</code>.
class DataRepositoryFailureDetails {
  final String? message;

  DataRepositoryFailureDetails({
    this.message,
  });
  factory DataRepositoryFailureDetails.fromJson(Map<String, dynamic> json) {
    return DataRepositoryFailureDetails(
      message: json['Message'] as String?,
    );
  }
}

enum DataRepositoryLifecycle {
  creating,
  available,
  misconfigured,
  updating,
  deleting,
}

extension DataRepositoryLifecycleValueExtension on DataRepositoryLifecycle {
  String toValue() {
    switch (this) {
      case DataRepositoryLifecycle.creating:
        return 'CREATING';
      case DataRepositoryLifecycle.available:
        return 'AVAILABLE';
      case DataRepositoryLifecycle.misconfigured:
        return 'MISCONFIGURED';
      case DataRepositoryLifecycle.updating:
        return 'UPDATING';
      case DataRepositoryLifecycle.deleting:
        return 'DELETING';
    }
  }
}

extension DataRepositoryLifecycleFromString on String {
  DataRepositoryLifecycle toDataRepositoryLifecycle() {
    switch (this) {
      case 'CREATING':
        return DataRepositoryLifecycle.creating;
      case 'AVAILABLE':
        return DataRepositoryLifecycle.available;
      case 'MISCONFIGURED':
        return DataRepositoryLifecycle.misconfigured;
      case 'UPDATING':
        return DataRepositoryLifecycle.updating;
      case 'DELETING':
        return DataRepositoryLifecycle.deleting;
    }
    throw Exception('$this is not known in enum DataRepositoryLifecycle');
  }
}

/// A description of the data repository task. You use data repository tasks to
/// perform bulk transfer operations between your Amazon FSx file system and its
/// linked data repository.
class DataRepositoryTask {
  final DateTime creationTime;
  final String fileSystemId;

  /// The lifecycle status of the data repository task, as follows:
  ///
  /// <ul>
  /// <li>
  /// <code>PENDING</code> - Amazon FSx has not started the task.
  /// </li>
  /// <li>
  /// <code>EXECUTING</code> - Amazon FSx is processing the task.
  /// </li>
  /// <li>
  /// <code>FAILED</code> - Amazon FSx was not able to complete the task. For
  /// example, there may be files the task failed to process. The
  /// <a>DataRepositoryTaskFailureDetails</a> property provides more information
  /// about task failures.
  /// </li>
  /// <li>
  /// <code>SUCCEEDED</code> - FSx completed the task successfully.
  /// </li>
  /// <li>
  /// <code>CANCELED</code> - Amazon FSx canceled the task and it did not
  /// complete.
  /// </li>
  /// <li>
  /// <code>CANCELING</code> - FSx is in process of canceling the task.
  /// </li>
  /// </ul> <note>
  /// You cannot delete an FSx for Lustre file system if there are data repository
  /// tasks for the file system in the <code>PENDING</code> or
  /// <code>EXECUTING</code> states. Please retry when the data repository task is
  /// finished (with a status of <code>CANCELED</code>, <code>SUCCEEDED</code>, or
  /// <code>FAILED</code>). You can use the DescribeDataRepositoryTask action to
  /// monitor the task status. Contact the FSx team if you need to delete your
  /// file system immediately.
  /// </note>
  final DataRepositoryTaskLifecycle lifecycle;

  /// The system-generated, unique 17-digit ID of the data repository task.
  final String taskId;

  /// The type of data repository task; EXPORT_TO_REPOSITORY is the only type
  /// currently supported.
  final DataRepositoryTaskType type;

  /// The time that Amazon FSx completed processing the task, populated after the
  /// task is complete.
  final DateTime? endTime;

  /// Failure message describing why the task failed, it is populated only when
  /// <code>Lifecycle</code> is set to <code>FAILED</code>.
  final DataRepositoryTaskFailureDetails? failureDetails;

  /// An array of paths on the Amazon FSx for Lustre file system that specify the
  /// data for the data repository task to process. For example, in an
  /// EXPORT_TO_REPOSITORY task, the paths specify which data to export to the
  /// linked data repository.
  ///
  /// (Default) If <code>Paths</code> is not specified, Amazon FSx uses the file
  /// system root directory.
  final List<String>? paths;
  final CompletionReport? report;
  final String? resourceARN;

  /// The time that Amazon FSx began processing the task.
  final DateTime? startTime;

  /// Provides the status of the number of files that the task has processed
  /// successfully and failed to process.
  final DataRepositoryTaskStatus? status;
  final List<Tag>? tags;

  DataRepositoryTask({
    required this.creationTime,
    required this.fileSystemId,
    required this.lifecycle,
    required this.taskId,
    required this.type,
    this.endTime,
    this.failureDetails,
    this.paths,
    this.report,
    this.resourceARN,
    this.startTime,
    this.status,
    this.tags,
  });
  factory DataRepositoryTask.fromJson(Map<String, dynamic> json) {
    return DataRepositoryTask(
      creationTime:
          nonNullableTimeStampFromJson(json['CreationTime'] as Object),
      fileSystemId: json['FileSystemId'] as String,
      lifecycle: (json['Lifecycle'] as String).toDataRepositoryTaskLifecycle(),
      taskId: json['TaskId'] as String,
      type: (json['Type'] as String).toDataRepositoryTaskType(),
      endTime: timeStampFromJson(json['EndTime']),
      failureDetails: json['FailureDetails'] != null
          ? DataRepositoryTaskFailureDetails.fromJson(
              json['FailureDetails'] as Map<String, dynamic>)
          : null,
      paths: (json['Paths'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
      report: json['Report'] != null
          ? CompletionReport.fromJson(json['Report'] as Map<String, dynamic>)
          : null,
      resourceARN: json['ResourceARN'] as String?,
      startTime: timeStampFromJson(json['StartTime']),
      status: json['Status'] != null
          ? DataRepositoryTaskStatus.fromJson(
              json['Status'] as Map<String, dynamic>)
          : null,
      tags: (json['Tags'] as List?)
          ?.whereNotNull()
          .map((e) => Tag.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// Provides information about why a data repository task failed. Only populated
/// when the task <code>Lifecycle</code> is set to <code>FAILED</code>.
class DataRepositoryTaskFailureDetails {
  final String? message;

  DataRepositoryTaskFailureDetails({
    this.message,
  });
  factory DataRepositoryTaskFailureDetails.fromJson(Map<String, dynamic> json) {
    return DataRepositoryTaskFailureDetails(
      message: json['Message'] as String?,
    );
  }
}

/// (Optional) An array of filter objects you can use to filter the response of
/// data repository tasks you will see in the the response. You can filter the
/// tasks returned in the response by one or more file system IDs, task
/// lifecycles, and by task type. A filter object consists of a filter
/// <code>Name</code>, and one or more <code>Values</code> for the filter.
class DataRepositoryTaskFilter {
  /// Name of the task property to use in filtering the tasks returned in the
  /// response.
  ///
  /// <ul>
  /// <li>
  /// Use <code>file-system-id</code> to retrieve data repository tasks for
  /// specific file systems.
  /// </li>
  /// <li>
  /// Use <code>task-lifecycle</code> to retrieve data repository tasks with one
  /// or more specific lifecycle states, as follows: CANCELED, EXECUTING, FAILED,
  /// PENDING, and SUCCEEDED.
  /// </li>
  /// </ul>
  final DataRepositoryTaskFilterName? name;

  /// Use Values to include the specific file system IDs and task lifecycle states
  /// for the filters you are using.
  final List<String>? values;

  DataRepositoryTaskFilter({
    this.name,
    this.values,
  });
  Map<String, dynamic> toJson() {
    final name = this.name;
    final values = this.values;
    return {
      if (name != null) 'Name': name.toValue(),
      if (values != null) 'Values': values,
    };
  }
}

enum DataRepositoryTaskFilterName {
  fileSystemId,
  taskLifecycle,
}

extension DataRepositoryTaskFilterNameValueExtension
    on DataRepositoryTaskFilterName {
  String toValue() {
    switch (this) {
      case DataRepositoryTaskFilterName.fileSystemId:
        return 'file-system-id';
      case DataRepositoryTaskFilterName.taskLifecycle:
        return 'task-lifecycle';
    }
  }
}

extension DataRepositoryTaskFilterNameFromString on String {
  DataRepositoryTaskFilterName toDataRepositoryTaskFilterName() {
    switch (this) {
      case 'file-system-id':
        return DataRepositoryTaskFilterName.fileSystemId;
      case 'task-lifecycle':
        return DataRepositoryTaskFilterName.taskLifecycle;
    }
    throw Exception('$this is not known in enum DataRepositoryTaskFilterName');
  }
}

enum DataRepositoryTaskLifecycle {
  pending,
  executing,
  failed,
  succeeded,
  canceled,
  canceling,
}

extension DataRepositoryTaskLifecycleValueExtension
    on DataRepositoryTaskLifecycle {
  String toValue() {
    switch (this) {
      case DataRepositoryTaskLifecycle.pending:
        return 'PENDING';
      case DataRepositoryTaskLifecycle.executing:
        return 'EXECUTING';
      case DataRepositoryTaskLifecycle.failed:
        return 'FAILED';
      case DataRepositoryTaskLifecycle.succeeded:
        return 'SUCCEEDED';
      case DataRepositoryTaskLifecycle.canceled:
        return 'CANCELED';
      case DataRepositoryTaskLifecycle.canceling:
        return 'CANCELING';
    }
  }
}

extension DataRepositoryTaskLifecycleFromString on String {
  DataRepositoryTaskLifecycle toDataRepositoryTaskLifecycle() {
    switch (this) {
      case 'PENDING':
        return DataRepositoryTaskLifecycle.pending;
      case 'EXECUTING':
        return DataRepositoryTaskLifecycle.executing;
      case 'FAILED':
        return DataRepositoryTaskLifecycle.failed;
      case 'SUCCEEDED':
        return DataRepositoryTaskLifecycle.succeeded;
      case 'CANCELED':
        return DataRepositoryTaskLifecycle.canceled;
      case 'CANCELING':
        return DataRepositoryTaskLifecycle.canceling;
    }
    throw Exception('$this is not known in enum DataRepositoryTaskLifecycle');
  }
}

/// Provides the task status showing a running total of the total number of
/// files to be processed, the number successfully processed, and the number of
/// files the task failed to process.
class DataRepositoryTaskStatus {
  /// A running total of the number of files that the task failed to process.
  final int? failedCount;

  /// The time at which the task status was last updated.
  final DateTime? lastUpdatedTime;

  /// A running total of the number of files that the task has successfully
  /// processed.
  final int? succeededCount;

  /// The total number of files that the task will process. While a task is
  /// executing, the sum of <code>SucceededCount</code> plus
  /// <code>FailedCount</code> may not equal <code>TotalCount</code>. When the
  /// task is complete, <code>TotalCount</code> equals the sum of
  /// <code>SucceededCount</code> plus <code>FailedCount</code>.
  final int? totalCount;

  DataRepositoryTaskStatus({
    this.failedCount,
    this.lastUpdatedTime,
    this.succeededCount,
    this.totalCount,
  });
  factory DataRepositoryTaskStatus.fromJson(Map<String, dynamic> json) {
    return DataRepositoryTaskStatus(
      failedCount: json['FailedCount'] as int?,
      lastUpdatedTime: timeStampFromJson(json['LastUpdatedTime']),
      succeededCount: json['SucceededCount'] as int?,
      totalCount: json['TotalCount'] as int?,
    );
  }
}

enum DataRepositoryTaskType {
  exportToRepository,
}

extension DataRepositoryTaskTypeValueExtension on DataRepositoryTaskType {
  String toValue() {
    switch (this) {
      case DataRepositoryTaskType.exportToRepository:
        return 'EXPORT_TO_REPOSITORY';
    }
  }
}

extension DataRepositoryTaskTypeFromString on String {
  DataRepositoryTaskType toDataRepositoryTaskType() {
    switch (this) {
      case 'EXPORT_TO_REPOSITORY':
        return DataRepositoryTaskType.exportToRepository;
    }
    throw Exception('$this is not known in enum DataRepositoryTaskType');
  }
}

/// The response object for <code>DeleteBackup</code> operation.
class DeleteBackupResponse {
  /// The ID of the backup deleted.
  final String? backupId;

  /// The lifecycle of the backup. Should be <code>DELETED</code>.
  final BackupLifecycle? lifecycle;

  DeleteBackupResponse({
    this.backupId,
    this.lifecycle,
  });
  factory DeleteBackupResponse.fromJson(Map<String, dynamic> json) {
    return DeleteBackupResponse(
      backupId: json['BackupId'] as String?,
      lifecycle: (json['Lifecycle'] as String?)?.toBackupLifecycle(),
    );
  }
}

/// The configuration object for the Amazon FSx for Lustre file system being
/// deleted in the <code>DeleteFileSystem</code> operation.
class DeleteFileSystemLustreConfiguration {
  /// Use if <code>SkipFinalBackup</code> is set to <code>false</code>, and you
  /// want to apply an array of tags to the final backup. If you have set the file
  /// system property <code>CopyTagsToBackups</code> to true, and you specify one
  /// or more <code>FinalBackupTags</code> when deleting a file system, Amazon FSx
  /// will not copy any existing file system tags to the backup.
  final List<Tag>? finalBackupTags;

  /// Set <code>SkipFinalBackup</code> to false if you want to take a final backup
  /// of the file system you are deleting. By default, Amazon FSx will not take a
  /// final backup on your behalf when the <code>DeleteFileSystem</code> operation
  /// is invoked. (Default = true)
  final bool? skipFinalBackup;

  DeleteFileSystemLustreConfiguration({
    this.finalBackupTags,
    this.skipFinalBackup,
  });
  Map<String, dynamic> toJson() {
    final finalBackupTags = this.finalBackupTags;
    final skipFinalBackup = this.skipFinalBackup;
    return {
      if (finalBackupTags != null) 'FinalBackupTags': finalBackupTags,
      if (skipFinalBackup != null) 'SkipFinalBackup': skipFinalBackup,
    };
  }
}

/// The response object for the Amazon FSx for Lustre file system being deleted
/// in the <code>DeleteFileSystem</code> operation.
class DeleteFileSystemLustreResponse {
  /// The ID of the final backup for this file system.
  final String? finalBackupId;

  /// The set of tags applied to the final backup.
  final List<Tag>? finalBackupTags;

  DeleteFileSystemLustreResponse({
    this.finalBackupId,
    this.finalBackupTags,
  });
  factory DeleteFileSystemLustreResponse.fromJson(Map<String, dynamic> json) {
    return DeleteFileSystemLustreResponse(
      finalBackupId: json['FinalBackupId'] as String?,
      finalBackupTags: (json['FinalBackupTags'] as List?)
          ?.whereNotNull()
          .map((e) => Tag.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// The response object for the <code>DeleteFileSystem</code> operation.
class DeleteFileSystemResponse {
  /// The ID of the file system being deleted.
  final String? fileSystemId;

  /// The file system lifecycle for the deletion request. Should be
  /// <code>DELETING</code>.
  final FileSystemLifecycle? lifecycle;
  final DeleteFileSystemLustreResponse? lustreResponse;
  final DeleteFileSystemWindowsResponse? windowsResponse;

  DeleteFileSystemResponse({
    this.fileSystemId,
    this.lifecycle,
    this.lustreResponse,
    this.windowsResponse,
  });
  factory DeleteFileSystemResponse.fromJson(Map<String, dynamic> json) {
    return DeleteFileSystemResponse(
      fileSystemId: json['FileSystemId'] as String?,
      lifecycle: (json['Lifecycle'] as String?)?.toFileSystemLifecycle(),
      lustreResponse: json['LustreResponse'] != null
          ? DeleteFileSystemLustreResponse.fromJson(
              json['LustreResponse'] as Map<String, dynamic>)
          : null,
      windowsResponse: json['WindowsResponse'] != null
          ? DeleteFileSystemWindowsResponse.fromJson(
              json['WindowsResponse'] as Map<String, dynamic>)
          : null,
    );
  }
}

/// The configuration object for the Microsoft Windows file system used in the
/// <code>DeleteFileSystem</code> operation.
class DeleteFileSystemWindowsConfiguration {
  /// A set of tags for your final backup.
  final List<Tag>? finalBackupTags;

  /// By default, Amazon FSx for Windows takes a final backup on your behalf when
  /// the <code>DeleteFileSystem</code> operation is invoked. Doing this helps
  /// protect you from data loss, and we highly recommend taking the final backup.
  /// If you want to skip this backup, use this flag to do so.
  final bool? skipFinalBackup;

  DeleteFileSystemWindowsConfiguration({
    this.finalBackupTags,
    this.skipFinalBackup,
  });
  Map<String, dynamic> toJson() {
    final finalBackupTags = this.finalBackupTags;
    final skipFinalBackup = this.skipFinalBackup;
    return {
      if (finalBackupTags != null) 'FinalBackupTags': finalBackupTags,
      if (skipFinalBackup != null) 'SkipFinalBackup': skipFinalBackup,
    };
  }
}

/// The response object for the Microsoft Windows file system used in the
/// <code>DeleteFileSystem</code> operation.
class DeleteFileSystemWindowsResponse {
  /// The ID of the final backup for this file system.
  final String? finalBackupId;

  /// The set of tags applied to the final backup.
  final List<Tag>? finalBackupTags;

  DeleteFileSystemWindowsResponse({
    this.finalBackupId,
    this.finalBackupTags,
  });
  factory DeleteFileSystemWindowsResponse.fromJson(Map<String, dynamic> json) {
    return DeleteFileSystemWindowsResponse(
      finalBackupId: json['FinalBackupId'] as String?,
      finalBackupTags: (json['FinalBackupTags'] as List?)
          ?.whereNotNull()
          .map((e) => Tag.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// Response object for <code>DescribeBackups</code> operation.
class DescribeBackupsResponse {
  /// Any array of backups.
  final List<Backup>? backups;

  /// This is present if there are more backups than returned in the response
  /// (String). You can use the <code>NextToken</code> value in the later request
  /// to fetch the backups.
  final String? nextToken;

  DescribeBackupsResponse({
    this.backups,
    this.nextToken,
  });
  factory DescribeBackupsResponse.fromJson(Map<String, dynamic> json) {
    return DescribeBackupsResponse(
      backups: (json['Backups'] as List?)
          ?.whereNotNull()
          .map((e) => Backup.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['NextToken'] as String?,
    );
  }
}

class DescribeDataRepositoryTasksResponse {
  /// The collection of data repository task descriptions returned.
  final List<DataRepositoryTask>? dataRepositoryTasks;
  final String? nextToken;

  DescribeDataRepositoryTasksResponse({
    this.dataRepositoryTasks,
    this.nextToken,
  });
  factory DescribeDataRepositoryTasksResponse.fromJson(
      Map<String, dynamic> json) {
    return DescribeDataRepositoryTasksResponse(
      dataRepositoryTasks: (json['DataRepositoryTasks'] as List?)
          ?.whereNotNull()
          .map((e) => DataRepositoryTask.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['NextToken'] as String?,
    );
  }
}

/// The response object for <code>DescribeFileSystemAliases</code> operation.
class DescribeFileSystemAliasesResponse {
  /// An array of one or more DNS aliases currently associated with the specified
  /// file system.
  final List<Alias>? aliases;

  /// Present if there are more DNS aliases than returned in the response
  /// (String). You can use the <code>NextToken</code> value in a later request to
  /// fetch additional descriptions.
  final String? nextToken;

  DescribeFileSystemAliasesResponse({
    this.aliases,
    this.nextToken,
  });
  factory DescribeFileSystemAliasesResponse.fromJson(
      Map<String, dynamic> json) {
    return DescribeFileSystemAliasesResponse(
      aliases: (json['Aliases'] as List?)
          ?.whereNotNull()
          .map((e) => Alias.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['NextToken'] as String?,
    );
  }
}

/// The response object for <code>DescribeFileSystems</code> operation.
class DescribeFileSystemsResponse {
  /// An array of file system descriptions.
  final List<FileSystem>? fileSystems;

  /// Present if there are more file systems than returned in the response
  /// (String). You can use the <code>NextToken</code> value in the later request
  /// to fetch the descriptions.
  final String? nextToken;

  DescribeFileSystemsResponse({
    this.fileSystems,
    this.nextToken,
  });
  factory DescribeFileSystemsResponse.fromJson(Map<String, dynamic> json) {
    return DescribeFileSystemsResponse(
      fileSystems: (json['FileSystems'] as List?)
          ?.whereNotNull()
          .map((e) => FileSystem.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['NextToken'] as String?,
    );
  }
}

/// The system generated response showing the DNS aliases that Amazon FSx is
/// attempting to disassociate from the file system. Use the API operation to
/// monitor the status of the aliases Amazon FSx is removing from the file
/// system.
class DisassociateFileSystemAliasesResponse {
  /// An array of one or more DNS aliases that Amazon FSx is attempting to
  /// disassociate from the file system.
  final List<Alias>? aliases;

  DisassociateFileSystemAliasesResponse({
    this.aliases,
  });
  factory DisassociateFileSystemAliasesResponse.fromJson(
      Map<String, dynamic> json) {
    return DisassociateFileSystemAliasesResponse(
      aliases: (json['Aliases'] as List?)
          ?.whereNotNull()
          .map((e) => Alias.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

enum DriveCacheType {
  none,
  read,
}

extension DriveCacheTypeValueExtension on DriveCacheType {
  String toValue() {
    switch (this) {
      case DriveCacheType.none:
        return 'NONE';
      case DriveCacheType.read:
        return 'READ';
    }
  }
}

extension DriveCacheTypeFromString on String {
  DriveCacheType toDriveCacheType() {
    switch (this) {
      case 'NONE':
        return DriveCacheType.none;
      case 'READ':
        return DriveCacheType.read;
    }
    throw Exception('$this is not known in enum DriveCacheType');
  }
}

/// A description of a specific Amazon FSx file system.
class FileSystem {
  /// A list of administrative actions for the file system that are in process or
  /// waiting to be processed. Administrative actions describe changes to the
  /// Windows file system that you have initiated using the
  /// <code>UpdateFileSystem</code> action.
  final List<AdministrativeAction>? administrativeActions;

  /// The time that the file system was created, in seconds (since
  /// 1970-01-01T00:00:00Z), also known as Unix time.
  final DateTime? creationTime;

  /// The DNS name for the file system.
  final String? dNSName;
  final FileSystemFailureDetails? failureDetails;

  /// The system-generated, unique 17-digit ID of the file system.
  final String? fileSystemId;

  /// The type of Amazon FSx file system, either <code>LUSTRE</code> or
  /// <code>WINDOWS</code>.
  final FileSystemType? fileSystemType;

  /// The ID of the AWS Key Management Service (AWS KMS) key used to encrypt the
  /// file system's data for Amazon FSx for Windows File Server file systems and
  /// persistent Amazon FSx for Lustre file systems at rest. In either case, if
  /// not specified, the Amazon FSx managed key is used. The scratch Amazon FSx
  /// for Lustre file systems are always encrypted at rest using Amazon FSx
  /// managed keys. For more information, see <a
  /// href="https://docs.aws.amazon.com/kms/latest/APIReference/API_Encrypt.html">Encrypt</a>
  /// in the <i>AWS Key Management Service API Reference</i>.
  final String? kmsKeyId;

  /// The lifecycle status of the file system, following are the possible values
  /// and what they mean:
  ///
  /// <ul>
  /// <li>
  /// <code>AVAILABLE</code> - The file system is in a healthy state, and is
  /// reachable and available for use.
  /// </li>
  /// <li>
  /// <code>CREATING</code> - Amazon FSx is creating the new file system.
  /// </li>
  /// <li>
  /// <code>DELETING</code> - Amazon FSx is deleting an existing file system.
  /// </li>
  /// <li>
  /// <code>FAILED</code> - An existing file system has experienced an
  /// unrecoverable failure. When creating a new file system, Amazon FSx was
  /// unable to create the file system.
  /// </li>
  /// <li>
  /// <code>MISCONFIGURED</code> indicates that the file system is in a failed but
  /// recoverable state.
  /// </li>
  /// <li>
  /// <code>UPDATING</code> indicates that the file system is undergoing a
  /// customer initiated update.
  /// </li>
  /// </ul>
  final FileSystemLifecycle? lifecycle;
  final LustreFileSystemConfiguration? lustreConfiguration;

  /// The IDs of the elastic network interface from which a specific file system
  /// is accessible. The elastic network interface is automatically created in the
  /// same VPC that the Amazon FSx file system was created in. For more
  /// information, see <a
  /// href="https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-eni.html">Elastic
  /// Network Interfaces</a> in the <i>Amazon EC2 User Guide.</i>
  ///
  /// For an Amazon FSx for Windows File Server file system, you can have one
  /// network interface ID. For an Amazon FSx for Lustre file system, you can have
  /// more than one.
  final List<String>? networkInterfaceIds;

  /// The AWS account that created the file system. If the file system was created
  /// by an AWS Identity and Access Management (IAM) user, the AWS account to
  /// which the IAM user belongs is the owner.
  final String? ownerId;

  /// The Amazon Resource Name (ARN) for the file system resource.
  final String? resourceARN;

  /// The storage capacity of the file system in gibibytes (GiB).
  final int? storageCapacity;

  /// The storage type of the file system. Valid values are <code>SSD</code> and
  /// <code>HDD</code>. If set to <code>SSD</code>, the file system uses solid
  /// state drive storage. If set to <code>HDD</code>, the file system uses hard
  /// disk drive storage.
  final StorageType? storageType;

  /// Specifies the IDs of the subnets that the file system is accessible from.
  /// For Windows <code>MULTI_AZ_1</code> file system deployment type, there are
  /// two subnet IDs, one for the preferred file server and one for the standby
  /// file server. The preferred file server subnet identified in the
  /// <code>PreferredSubnetID</code> property. All other file systems have only
  /// one subnet ID.
  ///
  /// For Lustre file systems, and Single-AZ Windows file systems, this is the ID
  /// of the subnet that contains the endpoint for the file system. For
  /// <code>MULTI_AZ_1</code> Windows file systems, the endpoint for the file
  /// system is available in the <code>PreferredSubnetID</code>.
  final List<String>? subnetIds;

  /// The tags to associate with the file system. For more information, see <a
  /// href="https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Using_Tags.html">Tagging
  /// Your Amazon EC2 Resources</a> in the <i>Amazon EC2 User Guide</i>.
  final List<Tag>? tags;

  /// The ID of the primary VPC for the file system.
  final String? vpcId;

  /// The configuration for this Microsoft Windows file system.
  final WindowsFileSystemConfiguration? windowsConfiguration;

  FileSystem({
    this.administrativeActions,
    this.creationTime,
    this.dNSName,
    this.failureDetails,
    this.fileSystemId,
    this.fileSystemType,
    this.kmsKeyId,
    this.lifecycle,
    this.lustreConfiguration,
    this.networkInterfaceIds,
    this.ownerId,
    this.resourceARN,
    this.storageCapacity,
    this.storageType,
    this.subnetIds,
    this.tags,
    this.vpcId,
    this.windowsConfiguration,
  });
  factory FileSystem.fromJson(Map<String, dynamic> json) {
    return FileSystem(
      administrativeActions: (json['AdministrativeActions'] as List?)
          ?.whereNotNull()
          .map((e) => AdministrativeAction.fromJson(e as Map<String, dynamic>))
          .toList(),
      creationTime: timeStampFromJson(json['CreationTime']),
      dNSName: json['DNSName'] as String?,
      failureDetails: json['FailureDetails'] != null
          ? FileSystemFailureDetails.fromJson(
              json['FailureDetails'] as Map<String, dynamic>)
          : null,
      fileSystemId: json['FileSystemId'] as String?,
      fileSystemType: (json['FileSystemType'] as String?)?.toFileSystemType(),
      kmsKeyId: json['KmsKeyId'] as String?,
      lifecycle: (json['Lifecycle'] as String?)?.toFileSystemLifecycle(),
      lustreConfiguration: json['LustreConfiguration'] != null
          ? LustreFileSystemConfiguration.fromJson(
              json['LustreConfiguration'] as Map<String, dynamic>)
          : null,
      networkInterfaceIds: (json['NetworkInterfaceIds'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
      ownerId: json['OwnerId'] as String?,
      resourceARN: json['ResourceARN'] as String?,
      storageCapacity: json['StorageCapacity'] as int?,
      storageType: (json['StorageType'] as String?)?.toStorageType(),
      subnetIds: (json['SubnetIds'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
      tags: (json['Tags'] as List?)
          ?.whereNotNull()
          .map((e) => Tag.fromJson(e as Map<String, dynamic>))
          .toList(),
      vpcId: json['VpcId'] as String?,
      windowsConfiguration: json['WindowsConfiguration'] != null
          ? WindowsFileSystemConfiguration.fromJson(
              json['WindowsConfiguration'] as Map<String, dynamic>)
          : null,
    );
  }
}

/// A structure providing details of any failures that occur when creating the
/// file system has failed.
class FileSystemFailureDetails {
  /// A message describing any failures that occurred during file system creation.
  final String? message;

  FileSystemFailureDetails({
    this.message,
  });
  factory FileSystemFailureDetails.fromJson(Map<String, dynamic> json) {
    return FileSystemFailureDetails(
      message: json['Message'] as String?,
    );
  }
}

/// The lifecycle status of the file system.
enum FileSystemLifecycle {
  available,
  creating,
  failed,
  deleting,
  misconfigured,
  updating,
}

extension FileSystemLifecycleValueExtension on FileSystemLifecycle {
  String toValue() {
    switch (this) {
      case FileSystemLifecycle.available:
        return 'AVAILABLE';
      case FileSystemLifecycle.creating:
        return 'CREATING';
      case FileSystemLifecycle.failed:
        return 'FAILED';
      case FileSystemLifecycle.deleting:
        return 'DELETING';
      case FileSystemLifecycle.misconfigured:
        return 'MISCONFIGURED';
      case FileSystemLifecycle.updating:
        return 'UPDATING';
    }
  }
}

extension FileSystemLifecycleFromString on String {
  FileSystemLifecycle toFileSystemLifecycle() {
    switch (this) {
      case 'AVAILABLE':
        return FileSystemLifecycle.available;
      case 'CREATING':
        return FileSystemLifecycle.creating;
      case 'FAILED':
        return FileSystemLifecycle.failed;
      case 'DELETING':
        return FileSystemLifecycle.deleting;
      case 'MISCONFIGURED':
        return FileSystemLifecycle.misconfigured;
      case 'UPDATING':
        return FileSystemLifecycle.updating;
    }
    throw Exception('$this is not known in enum FileSystemLifecycle');
  }
}

/// An enumeration specifying the currently ongoing maintenance operation.
enum FileSystemMaintenanceOperation {
  patching,
  backingUp,
}

extension FileSystemMaintenanceOperationValueExtension
    on FileSystemMaintenanceOperation {
  String toValue() {
    switch (this) {
      case FileSystemMaintenanceOperation.patching:
        return 'PATCHING';
      case FileSystemMaintenanceOperation.backingUp:
        return 'BACKING_UP';
    }
  }
}

extension FileSystemMaintenanceOperationFromString on String {
  FileSystemMaintenanceOperation toFileSystemMaintenanceOperation() {
    switch (this) {
      case 'PATCHING':
        return FileSystemMaintenanceOperation.patching;
      case 'BACKING_UP':
        return FileSystemMaintenanceOperation.backingUp;
    }
    throw Exception(
        '$this is not known in enum FileSystemMaintenanceOperation');
  }
}

/// The type of file system.
enum FileSystemType {
  windows,
  lustre,
}

extension FileSystemTypeValueExtension on FileSystemType {
  String toValue() {
    switch (this) {
      case FileSystemType.windows:
        return 'WINDOWS';
      case FileSystemType.lustre:
        return 'LUSTRE';
    }
  }
}

extension FileSystemTypeFromString on String {
  FileSystemType toFileSystemType() {
    switch (this) {
      case 'WINDOWS':
        return FileSystemType.windows;
      case 'LUSTRE':
        return FileSystemType.lustre;
    }
    throw Exception('$this is not known in enum FileSystemType');
  }
}

/// A filter used to restrict the results of describe calls. You can use
/// multiple filters to return results that meet all applied filter
/// requirements.
class Filter {
  /// The name for this filter.
  final FilterName? name;

  /// The values of the filter. These are all the values for any of the applied
  /// filters.
  final List<String>? values;

  Filter({
    this.name,
    this.values,
  });
  Map<String, dynamic> toJson() {
    final name = this.name;
    final values = this.values;
    return {
      if (name != null) 'Name': name.toValue(),
      if (values != null) 'Values': values,
    };
  }
}

/// The name for a filter.
enum FilterName {
  fileSystemId,
  backupType,
  fileSystemType,
}

extension FilterNameValueExtension on FilterName {
  String toValue() {
    switch (this) {
      case FilterName.fileSystemId:
        return 'file-system-id';
      case FilterName.backupType:
        return 'backup-type';
      case FilterName.fileSystemType:
        return 'file-system-type';
    }
  }
}

extension FilterNameFromString on String {
  FilterName toFilterName() {
    switch (this) {
      case 'file-system-id':
        return FilterName.fileSystemId;
      case 'backup-type':
        return FilterName.backupType;
      case 'file-system-type':
        return FilterName.fileSystemType;
    }
    throw Exception('$this is not known in enum FilterName');
  }
}

/// The response object for <code>ListTagsForResource</code> operation.
class ListTagsForResourceResponse {
  /// This is present if there are more tags than returned in the response
  /// (String). You can use the <code>NextToken</code> value in the later request
  /// to fetch the tags.
  final String? nextToken;

  /// A list of tags on the resource.
  final List<Tag>? tags;

  ListTagsForResourceResponse({
    this.nextToken,
    this.tags,
  });
  factory ListTagsForResourceResponse.fromJson(Map<String, dynamic> json) {
    return ListTagsForResourceResponse(
      nextToken: json['NextToken'] as String?,
      tags: (json['Tags'] as List?)
          ?.whereNotNull()
          .map((e) => Tag.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

enum LustreDeploymentType {
  scratch_1,
  scratch_2,
  persistent_1,
}

extension LustreDeploymentTypeValueExtension on LustreDeploymentType {
  String toValue() {
    switch (this) {
      case LustreDeploymentType.scratch_1:
        return 'SCRATCH_1';
      case LustreDeploymentType.scratch_2:
        return 'SCRATCH_2';
      case LustreDeploymentType.persistent_1:
        return 'PERSISTENT_1';
    }
  }
}

extension LustreDeploymentTypeFromString on String {
  LustreDeploymentType toLustreDeploymentType() {
    switch (this) {
      case 'SCRATCH_1':
        return LustreDeploymentType.scratch_1;
      case 'SCRATCH_2':
        return LustreDeploymentType.scratch_2;
      case 'PERSISTENT_1':
        return LustreDeploymentType.persistent_1;
    }
    throw Exception('$this is not known in enum LustreDeploymentType');
  }
}

/// The configuration for the Amazon FSx for Lustre file system.
class LustreFileSystemConfiguration {
  final int? automaticBackupRetentionDays;

  /// A boolean flag indicating whether tags on the file system should be copied
  /// to backups. If it's set to true, all tags on the file system are copied to
  /// all automatic backups and any user-initiated backups where the user doesn't
  /// specify any tags. If this value is true, and you specify one or more tags,
  /// only the specified tags are copied to backups. If you specify one or more
  /// tags when creating a user-initiated backup, no tags are copied from the file
  /// system, regardless of this value. (Default = false)
  final bool? copyTagsToBackups;
  final String? dailyAutomaticBackupStartTime;
  final DataRepositoryConfiguration? dataRepositoryConfiguration;

  /// The deployment type of the FSX for Lustre file system. <i>Scratch deployment
  /// type</i> is designed for temporary storage and shorter-term processing of
  /// data.
  ///
  /// <code>SCRATCH_1</code> and <code>SCRATCH_2</code> deployment types are best
  /// suited for when you need temporary storage and shorter-term processing of
  /// data. The <code>SCRATCH_2</code> deployment type provides in-transit
  /// encryption of data and higher burst throughput capacity than
  /// <code>SCRATCH_1</code>.
  ///
  /// The <code>PERSISTENT_1</code> deployment type is used for longer-term
  /// storage and workloads and encryption of data in transit. To learn more about
  /// deployment types, see <a
  /// href="https://docs.aws.amazon.com/fsx/latest/LustreGuide/lustre-deployment-types.html">
  /// FSx for Lustre Deployment Options</a>. (Default = <code>SCRATCH_1</code>)
  final LustreDeploymentType? deploymentType;

  /// The type of drive cache used by PERSISTENT_1 file systems that are
  /// provisioned with HDD storage devices. This parameter is required when
  /// storage type is HDD. Set to <code>READ</code>, improve the performance for
  /// frequently accessed files and allows 20% of the total storage capacity of
  /// the file system to be cached.
  ///
  /// This parameter is required when <code>StorageType</code> is set to HDD.
  final DriveCacheType? driveCacheType;

  /// You use the <code>MountName</code> value when mounting the file system.
  ///
  /// For the <code>SCRATCH_1</code> deployment type, this value is always
  /// "<code>fsx</code>". For <code>SCRATCH_2</code> and <code>PERSISTENT_1</code>
  /// deployment types, this value is a string that is unique within an AWS
  /// Region.
  final String? mountName;

  /// Per unit storage throughput represents the megabytes per second of read or
  /// write throughput per 1 tebibyte of storage provisioned. File system
  /// throughput capacity is equal to Storage capacity (TiB) *
  /// PerUnitStorageThroughput (MB/s/TiB). This option is only valid for
  /// <code>PERSISTENT_1</code> deployment types.
  ///
  /// Valid values for SSD storage: 50, 100, 200. Valid values for HDD storage:
  /// 12, 40.
  final int? perUnitStorageThroughput;

  /// The preferred start time to perform weekly maintenance, formatted d:HH:MM in
  /// the UTC time zone. d is the weekday number, from 1 through 7, beginning with
  /// Monday and ending with Sunday.
  final String? weeklyMaintenanceStartTime;

  LustreFileSystemConfiguration({
    this.automaticBackupRetentionDays,
    this.copyTagsToBackups,
    this.dailyAutomaticBackupStartTime,
    this.dataRepositoryConfiguration,
    this.deploymentType,
    this.driveCacheType,
    this.mountName,
    this.perUnitStorageThroughput,
    this.weeklyMaintenanceStartTime,
  });
  factory LustreFileSystemConfiguration.fromJson(Map<String, dynamic> json) {
    return LustreFileSystemConfiguration(
      automaticBackupRetentionDays:
          json['AutomaticBackupRetentionDays'] as int?,
      copyTagsToBackups: json['CopyTagsToBackups'] as bool?,
      dailyAutomaticBackupStartTime:
          json['DailyAutomaticBackupStartTime'] as String?,
      dataRepositoryConfiguration: json['DataRepositoryConfiguration'] != null
          ? DataRepositoryConfiguration.fromJson(
              json['DataRepositoryConfiguration'] as Map<String, dynamic>)
          : null,
      deploymentType:
          (json['DeploymentType'] as String?)?.toLustreDeploymentType(),
      driveCacheType: (json['DriveCacheType'] as String?)?.toDriveCacheType(),
      mountName: json['MountName'] as String?,
      perUnitStorageThroughput: json['PerUnitStorageThroughput'] as int?,
      weeklyMaintenanceStartTime: json['WeeklyMaintenanceStartTime'] as String?,
    );
  }
}

enum ReportFormat {
  reportCsv_20191124,
}

extension ReportFormatValueExtension on ReportFormat {
  String toValue() {
    switch (this) {
      case ReportFormat.reportCsv_20191124:
        return 'REPORT_CSV_20191124';
    }
  }
}

extension ReportFormatFromString on String {
  ReportFormat toReportFormat() {
    switch (this) {
      case 'REPORT_CSV_20191124':
        return ReportFormat.reportCsv_20191124;
    }
    throw Exception('$this is not known in enum ReportFormat');
  }
}

enum ReportScope {
  failedFilesOnly,
}

extension ReportScopeValueExtension on ReportScope {
  String toValue() {
    switch (this) {
      case ReportScope.failedFilesOnly:
        return 'FAILED_FILES_ONLY';
    }
  }
}

extension ReportScopeFromString on String {
  ReportScope toReportScope() {
    switch (this) {
      case 'FAILED_FILES_ONLY':
        return ReportScope.failedFilesOnly;
    }
    throw Exception('$this is not known in enum ReportScope');
  }
}

/// The configuration of the self-managed Microsoft Active Directory (AD)
/// directory to which the Windows File Server instance is joined.
class SelfManagedActiveDirectoryAttributes {
  /// A list of up to two IP addresses of DNS servers or domain controllers in the
  /// self-managed AD directory.
  final List<String>? dnsIps;

  /// The fully qualified domain name of the self-managed AD directory.
  final String? domainName;

  /// The name of the domain group whose members have administrative privileges
  /// for the FSx file system.
  final String? fileSystemAdministratorsGroup;

  /// The fully qualified distinguished name of the organizational unit within the
  /// self-managed AD directory to which the Windows File Server instance is
  /// joined.
  final String? organizationalUnitDistinguishedName;

  /// The user name for the service account on your self-managed AD domain that
  /// FSx uses to join to your AD domain.
  final String? userName;

  SelfManagedActiveDirectoryAttributes({
    this.dnsIps,
    this.domainName,
    this.fileSystemAdministratorsGroup,
    this.organizationalUnitDistinguishedName,
    this.userName,
  });
  factory SelfManagedActiveDirectoryAttributes.fromJson(
      Map<String, dynamic> json) {
    return SelfManagedActiveDirectoryAttributes(
      dnsIps: (json['DnsIps'] as List?)
          ?.whereNotNull()
          .map((e) => e as String)
          .toList(),
      domainName: json['DomainName'] as String?,
      fileSystemAdministratorsGroup:
          json['FileSystemAdministratorsGroup'] as String?,
      organizationalUnitDistinguishedName:
          json['OrganizationalUnitDistinguishedName'] as String?,
      userName: json['UserName'] as String?,
    );
  }
}

/// The configuration that Amazon FSx uses to join the Windows File Server
/// instance to your self-managed (including on-premises) Microsoft Active
/// Directory (AD) directory.
class SelfManagedActiveDirectoryConfiguration {
  /// A list of up to two IP addresses of DNS servers or domain controllers in the
  /// self-managed AD directory. The IP addresses need to be either in the same
  /// VPC CIDR range as the one in which your Amazon FSx file system is being
  /// created, or in the private IP version 4 (IPv4) address ranges, as specified
  /// in <a href="http://www.faqs.org/rfcs/rfc1918.html">RFC 1918</a>:
  ///
  /// <ul>
  /// <li>
  /// 10.0.0.0 - 10.255.255.255 (10/8 prefix)
  /// </li>
  /// <li>
  /// 172.16.0.0 - 172.31.255.255 (172.16/12 prefix)
  /// </li>
  /// <li>
  /// 192.168.0.0 - 192.168.255.255 (192.168/16 prefix)
  /// </li>
  /// </ul>
  final List<String> dnsIps;

  /// The fully qualified domain name of the self-managed AD directory, such as
  /// <code>corp.example.com</code>.
  final String domainName;

  /// The password for the service account on your self-managed AD domain that
  /// Amazon FSx will use to join to your AD domain.
  final String password;

  /// The user name for the service account on your self-managed AD domain that
  /// Amazon FSx will use to join to your AD domain. This account must have the
  /// permission to join computers to the domain in the organizational unit
  /// provided in <code>OrganizationalUnitDistinguishedName</code>, or in the
  /// default location of your AD domain.
  final String userName;

  /// (Optional) The name of the domain group whose members are granted
  /// administrative privileges for the file system. Administrative privileges
  /// include taking ownership of files and folders, setting audit controls (audit
  /// ACLs) on files and folders, and administering the file system remotely by
  /// using the FSx Remote PowerShell. The group that you specify must already
  /// exist in your domain. If you don't provide one, your AD domain's Domain
  /// Admins group is used.
  final String? fileSystemAdministratorsGroup;

  /// (Optional) The fully qualified distinguished name of the organizational unit
  /// within your self-managed AD directory that the Windows File Server instance
  /// will join. Amazon FSx only accepts OU as the direct parent of the file
  /// system. An example is <code>OU=FSx,DC=yourdomain,DC=corp,DC=com</code>. To
  /// learn more, see <a href="https://tools.ietf.org/html/rfc2253">RFC 2253</a>.
  /// If none is provided, the FSx file system is created in the default location
  /// of your self-managed AD directory.
  /// <important>
  /// Only Organizational Unit (OU) objects can be the direct parent of the file
  /// system that you're creating.
  /// </important>
  final String? organizationalUnitDistinguishedName;

  SelfManagedActiveDirectoryConfiguration({
    required this.dnsIps,
    required this.domainName,
    required this.password,
    required this.userName,
    this.fileSystemAdministratorsGroup,
    this.organizationalUnitDistinguishedName,
  });
  Map<String, dynamic> toJson() {
    final dnsIps = this.dnsIps;
    final domainName = this.domainName;
    final password = this.password;
    final userName = this.userName;
    final fileSystemAdministratorsGroup = this.fileSystemAdministratorsGroup;
    final organizationalUnitDistinguishedName =
        this.organizationalUnitDistinguishedName;
    return {
      'DnsIps': dnsIps,
      'DomainName': domainName,
      'Password': password,
      'UserName': userName,
      if (fileSystemAdministratorsGroup != null)
        'FileSystemAdministratorsGroup': fileSystemAdministratorsGroup,
      if (organizationalUnitDistinguishedName != null)
        'OrganizationalUnitDistinguishedName':
            organizationalUnitDistinguishedName,
    };
  }
}

/// The configuration that Amazon FSx uses to join the Windows File Server
/// instance to a self-managed Microsoft Active Directory (AD) directory.
class SelfManagedActiveDirectoryConfigurationUpdates {
  /// A list of up to two IP addresses of DNS servers or domain controllers in the
  /// self-managed AD directory.
  final List<String>? dnsIps;

  /// The password for the service account on your self-managed AD domain that
  /// Amazon FSx will use to join to your AD domain.
  final String? password;

  /// The user name for the service account on your self-managed AD domain that
  /// Amazon FSx will use to join to your AD domain. This account must have the
  /// permission to join computers to the domain in the organizational unit
  /// provided in <code>OrganizationalUnitDistinguishedName</code>.
  final String? userName;

  SelfManagedActiveDirectoryConfigurationUpdates({
    this.dnsIps,
    this.password,
    this.userName,
  });
  Map<String, dynamic> toJson() {
    final dnsIps = this.dnsIps;
    final password = this.password;
    final userName = this.userName;
    return {
      if (dnsIps != null) 'DnsIps': dnsIps,
      if (password != null) 'Password': password,
      if (userName != null) 'UserName': userName,
    };
  }
}

enum Status {
  failed,
  inProgress,
  pending,
  completed,
  updatedOptimizing,
}

extension StatusValueExtension on Status {
  String toValue() {
    switch (this) {
      case Status.failed:
        return 'FAILED';
      case Status.inProgress:
        return 'IN_PROGRESS';
      case Status.pending:
        return 'PENDING';
      case Status.completed:
        return 'COMPLETED';
      case Status.updatedOptimizing:
        return 'UPDATED_OPTIMIZING';
    }
  }
}

extension StatusFromString on String {
  Status toStatus() {
    switch (this) {
      case 'FAILED':
        return Status.failed;
      case 'IN_PROGRESS':
        return Status.inProgress;
      case 'PENDING':
        return Status.pending;
      case 'COMPLETED':
        return Status.completed;
      case 'UPDATED_OPTIMIZING':
        return Status.updatedOptimizing;
    }
    throw Exception('$this is not known in enum Status');
  }
}

/// The storage type for your Amazon FSx file system.
enum StorageType {
  ssd,
  hdd,
}

extension StorageTypeValueExtension on StorageType {
  String toValue() {
    switch (this) {
      case StorageType.ssd:
        return 'SSD';
      case StorageType.hdd:
        return 'HDD';
    }
  }
}

extension StorageTypeFromString on String {
  StorageType toStorageType() {
    switch (this) {
      case 'SSD':
        return StorageType.ssd;
      case 'HDD':
        return StorageType.hdd;
    }
    throw Exception('$this is not known in enum StorageType');
  }
}

/// Specifies a key-value pair for a resource tag.
class Tag {
  /// A value that specifies the <code>TagKey</code>, the name of the tag. Tag
  /// keys must be unique for the resource to which they are attached.
  final String key;

  /// A value that specifies the <code>TagValue</code>, the value assigned to the
  /// corresponding tag key. Tag values can be null and don't have to be unique in
  /// a tag set. For example, you can have a key-value pair in a tag set of
  /// <code>finances : April</code> and also of <code>payroll : April</code>.
  final String value;

  Tag({
    required this.key,
    required this.value,
  });
  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      key: json['Key'] as String,
      value: json['Value'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final key = this.key;
    final value = this.value;
    return {
      'Key': key,
      'Value': value,
    };
  }
}

/// The response object for the <code>TagResource</code> operation.
class TagResourceResponse {
  TagResourceResponse();
  factory TagResourceResponse.fromJson(Map<String, dynamic> _) {
    return TagResourceResponse();
  }
}

/// The response object for <code>UntagResource</code> action.
class UntagResourceResponse {
  UntagResourceResponse();
  factory UntagResourceResponse.fromJson(Map<String, dynamic> _) {
    return UntagResourceResponse();
  }
}

/// The configuration object for Amazon FSx for Lustre file systems used in the
/// <code>UpdateFileSystem</code> operation.
class UpdateFileSystemLustreConfiguration {
  /// (Optional) When you create your file system, your existing S3 objects appear
  /// as file and directory listings. Use this property to choose how Amazon FSx
  /// keeps your file and directory listing up to date as you add or modify
  /// objects in your linked S3 bucket. <code>AutoImportPolicy</code> can have the
  /// following values:
  ///
  /// <ul>
  /// <li>
  /// <code>NONE</code> - (Default) AutoImport is off. Amazon FSx only updates
  /// file and directory listings from the linked S3 bucket when the file system
  /// is created. FSx does not update the file and directory listing for any new
  /// or changed objects after choosing this option.
  /// </li>
  /// <li>
  /// <code>NEW</code> - AutoImport is on. Amazon FSx automatically imports
  /// directory listings of any new objects added to the linked S3 bucket that do
  /// not currently exist in the FSx file system.
  /// </li>
  /// <li>
  /// <code>NEW_CHANGED</code> - AutoImport is on. Amazon FSx automatically
  /// imports file and directory listings of any new objects added to the S3
  /// bucket and any existing objects that are changed in the S3 bucket after you
  /// choose this option.
  /// </li>
  /// </ul>
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/fsx/latest/LustreGuide/autoimport-data-repo.html">Automatically
  /// import updates from your S3 bucket</a>.
  final AutoImportPolicyType? autoImportPolicy;
  final int? automaticBackupRetentionDays;
  final String? dailyAutomaticBackupStartTime;

  /// (Optional) The preferred start time to perform weekly maintenance, formatted
  /// d:HH:MM in the UTC time zone. d is the weekday number, from 1 through 7,
  /// beginning with Monday and ending with Sunday.
  final String? weeklyMaintenanceStartTime;

  UpdateFileSystemLustreConfiguration({
    this.autoImportPolicy,
    this.automaticBackupRetentionDays,
    this.dailyAutomaticBackupStartTime,
    this.weeklyMaintenanceStartTime,
  });
  Map<String, dynamic> toJson() {
    final autoImportPolicy = this.autoImportPolicy;
    final automaticBackupRetentionDays = this.automaticBackupRetentionDays;
    final dailyAutomaticBackupStartTime = this.dailyAutomaticBackupStartTime;
    final weeklyMaintenanceStartTime = this.weeklyMaintenanceStartTime;
    return {
      if (autoImportPolicy != null)
        'AutoImportPolicy': autoImportPolicy.toValue(),
      if (automaticBackupRetentionDays != null)
        'AutomaticBackupRetentionDays': automaticBackupRetentionDays,
      if (dailyAutomaticBackupStartTime != null)
        'DailyAutomaticBackupStartTime': dailyAutomaticBackupStartTime,
      if (weeklyMaintenanceStartTime != null)
        'WeeklyMaintenanceStartTime': weeklyMaintenanceStartTime,
    };
  }
}

/// The response object for the <code>UpdateFileSystem</code> operation.
class UpdateFileSystemResponse {
  /// A description of the file system that was updated.
  final FileSystem? fileSystem;

  UpdateFileSystemResponse({
    this.fileSystem,
  });
  factory UpdateFileSystemResponse.fromJson(Map<String, dynamic> json) {
    return UpdateFileSystemResponse(
      fileSystem: json['FileSystem'] != null
          ? FileSystem.fromJson(json['FileSystem'] as Map<String, dynamic>)
          : null,
    );
  }
}

/// Updates the configuration for an existing Amazon FSx for Windows File Server
/// file system. Amazon FSx only overwrites existing properties with non-null
/// values provided in the request.
class UpdateFileSystemWindowsConfiguration {
  /// The number of days to retain automatic daily backups. Setting this to zero
  /// (0) disables automatic daily backups. You can retain automatic daily backups
  /// for a maximum of 90 days. For more information, see <a
  /// href="https://docs.aws.amazon.com/fsx/latest/WindowsGuide/using-backups.html#automatic-backups">Working
  /// with Automatic Daily Backups</a>.
  final int? automaticBackupRetentionDays;

  /// The preferred time to start the daily automatic backup, in the UTC time
  /// zone, for example, <code>02:00</code>
  final String? dailyAutomaticBackupStartTime;

  /// The configuration Amazon FSx uses to join the Windows File Server instance
  /// to the self-managed Microsoft AD directory. You cannot make a self-managed
  /// Microsoft AD update request if there is an existing self-managed Microsoft
  /// AD update request in progress.
  final SelfManagedActiveDirectoryConfigurationUpdates?
      selfManagedActiveDirectoryConfiguration;

  /// Sets the target value for a file system's throughput capacity, in MB/s, that
  /// you are updating the file system to. Valid values are 8, 16, 32, 64, 128,
  /// 256, 512, 1024, 2048. You cannot make a throughput capacity update request
  /// if there is an existing throughput capacity update request in progress. For
  /// more information, see <a
  /// href="https://docs.aws.amazon.com/fsx/latest/WindowsGuide/managing-throughput-capacity.html">Managing
  /// Throughput Capacity</a>.
  final int? throughputCapacity;

  /// The preferred start time to perform weekly maintenance, formatted d:HH:MM in
  /// the UTC time zone. Where d is the weekday number, from 1 through 7, with 1 =
  /// Monday and 7 = Sunday.
  final String? weeklyMaintenanceStartTime;

  UpdateFileSystemWindowsConfiguration({
    this.automaticBackupRetentionDays,
    this.dailyAutomaticBackupStartTime,
    this.selfManagedActiveDirectoryConfiguration,
    this.throughputCapacity,
    this.weeklyMaintenanceStartTime,
  });
  Map<String, dynamic> toJson() {
    final automaticBackupRetentionDays = this.automaticBackupRetentionDays;
    final dailyAutomaticBackupStartTime = this.dailyAutomaticBackupStartTime;
    final selfManagedActiveDirectoryConfiguration =
        this.selfManagedActiveDirectoryConfiguration;
    final throughputCapacity = this.throughputCapacity;
    final weeklyMaintenanceStartTime = this.weeklyMaintenanceStartTime;
    return {
      if (automaticBackupRetentionDays != null)
        'AutomaticBackupRetentionDays': automaticBackupRetentionDays,
      if (dailyAutomaticBackupStartTime != null)
        'DailyAutomaticBackupStartTime': dailyAutomaticBackupStartTime,
      if (selfManagedActiveDirectoryConfiguration != null)
        'SelfManagedActiveDirectoryConfiguration':
            selfManagedActiveDirectoryConfiguration,
      if (throughputCapacity != null) 'ThroughputCapacity': throughputCapacity,
      if (weeklyMaintenanceStartTime != null)
        'WeeklyMaintenanceStartTime': weeklyMaintenanceStartTime,
    };
  }
}

enum WindowsDeploymentType {
  multiAz_1,
  singleAz_1,
  singleAz_2,
}

extension WindowsDeploymentTypeValueExtension on WindowsDeploymentType {
  String toValue() {
    switch (this) {
      case WindowsDeploymentType.multiAz_1:
        return 'MULTI_AZ_1';
      case WindowsDeploymentType.singleAz_1:
        return 'SINGLE_AZ_1';
      case WindowsDeploymentType.singleAz_2:
        return 'SINGLE_AZ_2';
    }
  }
}

extension WindowsDeploymentTypeFromString on String {
  WindowsDeploymentType toWindowsDeploymentType() {
    switch (this) {
      case 'MULTI_AZ_1':
        return WindowsDeploymentType.multiAz_1;
      case 'SINGLE_AZ_1':
        return WindowsDeploymentType.singleAz_1;
      case 'SINGLE_AZ_2':
        return WindowsDeploymentType.singleAz_2;
    }
    throw Exception('$this is not known in enum WindowsDeploymentType');
  }
}

/// The configuration for this Microsoft Windows file system.
class WindowsFileSystemConfiguration {
  /// The ID for an existing Microsoft Active Directory instance that the file
  /// system should join when it's created.
  final String? activeDirectoryId;
  final List<Alias>? aliases;

  /// The number of days to retain automatic backups. Setting this to 0 disables
  /// automatic backups. You can retain automatic backups for a maximum of 90
  /// days.
  final int? automaticBackupRetentionDays;

  /// A boolean flag indicating whether tags on the file system should be copied
  /// to backups. This value defaults to false. If it's set to true, all tags on
  /// the file system are copied to all automatic backups and any user-initiated
  /// backups where the user doesn't specify any tags. If this value is true, and
  /// you specify one or more tags, only the specified tags are copied to backups.
  /// If you specify one or more tags when creating a user-initiated backup, no
  /// tags are copied from the file system, regardless of this value.
  final bool? copyTagsToBackups;

  /// The preferred time to take daily automatic backups, in the UTC time zone.
  final String? dailyAutomaticBackupStartTime;

  /// Specifies the file system deployment type, valid values are the following:
  ///
  /// <ul>
  /// <li>
  /// <code>MULTI_AZ_1</code> - Specifies a high availability file system that is
  /// configured for Multi-AZ redundancy to tolerate temporary Availability Zone
  /// (AZ) unavailability, and supports SSD and HDD storage.
  /// </li>
  /// <li>
  /// <code>SINGLE_AZ_1</code> - (Default) Specifies a file system that is
  /// configured for single AZ redundancy, only supports SSD storage.
  /// </li>
  /// <li>
  /// <code>SINGLE_AZ_2</code> - Latest generation Single AZ file system.
  /// Specifies a file system that is configured for single AZ redundancy and
  /// supports SSD and HDD storage.
  /// </li>
  /// </ul>
  /// For more information, see <a
  /// href="https://docs.aws.amazon.com/fsx/latest/WindowsGuide/high-availability-multiAZ.html">Single-AZ
  /// and Multi-AZ File Systems</a>.
  final WindowsDeploymentType? deploymentType;

  /// The list of maintenance operations in progress for this file system.
  final List<FileSystemMaintenanceOperation>? maintenanceOperationsInProgress;

  /// For <code>MULTI_AZ_1</code> deployment types, the IP address of the primary,
  /// or preferred, file server.
  ///
  /// Use this IP address when mounting the file system on Linux SMB clients or
  /// Windows SMB clients that are not joined to a Microsoft Active Directory.
  /// Applicable for all Windows file system deployment types. This IP address is
  /// temporarily unavailable when the file system is undergoing maintenance. For
  /// Linux and Windows SMB clients that are joined to an Active Directory, use
  /// the file system's DNSName instead. For more information on mapping and
  /// mounting file shares, see <a
  /// href="https://docs.aws.amazon.com/fsx/latest/WindowsGuide/accessing-file-shares.html">Accessing
  /// File Shares</a>.
  final String? preferredFileServerIp;

  /// For <code>MULTI_AZ_1</code> deployment types, it specifies the ID of the
  /// subnet where the preferred file server is located. Must be one of the two
  /// subnet IDs specified in <code>SubnetIds</code> property. Amazon FSx serves
  /// traffic from this subnet except in the event of a failover to the secondary
  /// file server.
  ///
  /// For <code>SINGLE_AZ_1</code> and <code>SINGLE_AZ_2</code> deployment types,
  /// this value is the same as that for <code>SubnetIDs</code>. For more
  /// information, see <a
  /// href="https://docs.aws.amazon.com/fsx/latest/WindowsGuide/high-availability-multiAZ.html#single-multi-az-resources">Availability
  /// and Durability: Single-AZ and Multi-AZ File Systems</a>
  final String? preferredSubnetId;

  /// For <code>MULTI_AZ_1</code> deployment types, use this endpoint when
  /// performing administrative tasks on the file system using Amazon FSx Remote
  /// PowerShell.
  ///
  /// For <code>SINGLE_AZ_1</code> and <code>SINGLE_AZ_2</code> deployment types,
  /// this is the DNS name of the file system.
  ///
  /// This endpoint is temporarily unavailable when the file system is undergoing
  /// maintenance.
  final String? remoteAdministrationEndpoint;
  final SelfManagedActiveDirectoryAttributes?
      selfManagedActiveDirectoryConfiguration;

  /// The throughput of an Amazon FSx file system, measured in megabytes per
  /// second.
  final int? throughputCapacity;

  /// The preferred start time to perform weekly maintenance, formatted d:HH:MM in
  /// the UTC time zone. d is the weekday number, from 1 through 7, beginning with
  /// Monday and ending with Sunday.
  final String? weeklyMaintenanceStartTime;

  WindowsFileSystemConfiguration({
    this.activeDirectoryId,
    this.aliases,
    this.automaticBackupRetentionDays,
    this.copyTagsToBackups,
    this.dailyAutomaticBackupStartTime,
    this.deploymentType,
    this.maintenanceOperationsInProgress,
    this.preferredFileServerIp,
    this.preferredSubnetId,
    this.remoteAdministrationEndpoint,
    this.selfManagedActiveDirectoryConfiguration,
    this.throughputCapacity,
    this.weeklyMaintenanceStartTime,
  });
  factory WindowsFileSystemConfiguration.fromJson(Map<String, dynamic> json) {
    return WindowsFileSystemConfiguration(
      activeDirectoryId: json['ActiveDirectoryId'] as String?,
      aliases: (json['Aliases'] as List?)
          ?.whereNotNull()
          .map((e) => Alias.fromJson(e as Map<String, dynamic>))
          .toList(),
      automaticBackupRetentionDays:
          json['AutomaticBackupRetentionDays'] as int?,
      copyTagsToBackups: json['CopyTagsToBackups'] as bool?,
      dailyAutomaticBackupStartTime:
          json['DailyAutomaticBackupStartTime'] as String?,
      deploymentType:
          (json['DeploymentType'] as String?)?.toWindowsDeploymentType(),
      maintenanceOperationsInProgress:
          (json['MaintenanceOperationsInProgress'] as List?)
              ?.whereNotNull()
              .map((e) => (e as String).toFileSystemMaintenanceOperation())
              .toList(),
      preferredFileServerIp: json['PreferredFileServerIp'] as String?,
      preferredSubnetId: json['PreferredSubnetId'] as String?,
      remoteAdministrationEndpoint:
          json['RemoteAdministrationEndpoint'] as String?,
      selfManagedActiveDirectoryConfiguration:
          json['SelfManagedActiveDirectoryConfiguration'] != null
              ? SelfManagedActiveDirectoryAttributes.fromJson(
                  json['SelfManagedActiveDirectoryConfiguration']
                      as Map<String, dynamic>)
              : null,
      throughputCapacity: json['ThroughputCapacity'] as int?,
      weeklyMaintenanceStartTime: json['WeeklyMaintenanceStartTime'] as String?,
    );
  }
}

class ActiveDirectoryError extends _s.GenericAwsException {
  ActiveDirectoryError({String? type, String? message})
      : super(type: type, code: 'ActiveDirectoryError', message: message);
}

class BackupInProgress extends _s.GenericAwsException {
  BackupInProgress({String? type, String? message})
      : super(type: type, code: 'BackupInProgress', message: message);
}

class BackupNotFound extends _s.GenericAwsException {
  BackupNotFound({String? type, String? message})
      : super(type: type, code: 'BackupNotFound', message: message);
}

class BackupRestoring extends _s.GenericAwsException {
  BackupRestoring({String? type, String? message})
      : super(type: type, code: 'BackupRestoring', message: message);
}

class BadRequest extends _s.GenericAwsException {
  BadRequest({String? type, String? message})
      : super(type: type, code: 'BadRequest', message: message);
}

class DataRepositoryTaskEnded extends _s.GenericAwsException {
  DataRepositoryTaskEnded({String? type, String? message})
      : super(type: type, code: 'DataRepositoryTaskEnded', message: message);
}

class DataRepositoryTaskExecuting extends _s.GenericAwsException {
  DataRepositoryTaskExecuting({String? type, String? message})
      : super(
            type: type, code: 'DataRepositoryTaskExecuting', message: message);
}

class DataRepositoryTaskNotFound extends _s.GenericAwsException {
  DataRepositoryTaskNotFound({String? type, String? message})
      : super(type: type, code: 'DataRepositoryTaskNotFound', message: message);
}

class FileSystemNotFound extends _s.GenericAwsException {
  FileSystemNotFound({String? type, String? message})
      : super(type: type, code: 'FileSystemNotFound', message: message);
}

class IncompatibleParameterError extends _s.GenericAwsException {
  IncompatibleParameterError({String? type, String? message})
      : super(type: type, code: 'IncompatibleParameterError', message: message);
}

class InternalServerError extends _s.GenericAwsException {
  InternalServerError({String? type, String? message})
      : super(type: type, code: 'InternalServerError', message: message);
}

class InvalidExportPath extends _s.GenericAwsException {
  InvalidExportPath({String? type, String? message})
      : super(type: type, code: 'InvalidExportPath', message: message);
}

class InvalidImportPath extends _s.GenericAwsException {
  InvalidImportPath({String? type, String? message})
      : super(type: type, code: 'InvalidImportPath', message: message);
}

class InvalidNetworkSettings extends _s.GenericAwsException {
  InvalidNetworkSettings({String? type, String? message})
      : super(type: type, code: 'InvalidNetworkSettings', message: message);
}

class InvalidPerUnitStorageThroughput extends _s.GenericAwsException {
  InvalidPerUnitStorageThroughput({String? type, String? message})
      : super(
            type: type,
            code: 'InvalidPerUnitStorageThroughput',
            message: message);
}

class MissingFileSystemConfiguration extends _s.GenericAwsException {
  MissingFileSystemConfiguration({String? type, String? message})
      : super(
            type: type,
            code: 'MissingFileSystemConfiguration',
            message: message);
}

class NotServiceResourceError extends _s.GenericAwsException {
  NotServiceResourceError({String? type, String? message})
      : super(type: type, code: 'NotServiceResourceError', message: message);
}

class ResourceDoesNotSupportTagging extends _s.GenericAwsException {
  ResourceDoesNotSupportTagging({String? type, String? message})
      : super(
            type: type,
            code: 'ResourceDoesNotSupportTagging',
            message: message);
}

class ResourceNotFound extends _s.GenericAwsException {
  ResourceNotFound({String? type, String? message})
      : super(type: type, code: 'ResourceNotFound', message: message);
}

class ServiceLimitExceeded extends _s.GenericAwsException {
  ServiceLimitExceeded({String? type, String? message})
      : super(type: type, code: 'ServiceLimitExceeded', message: message);
}

class UnsupportedOperation extends _s.GenericAwsException {
  UnsupportedOperation({String? type, String? message})
      : super(type: type, code: 'UnsupportedOperation', message: message);
}

final _exceptionFns = <String, _s.AwsExceptionFn>{
  'ActiveDirectoryError': (type, message) =>
      ActiveDirectoryError(type: type, message: message),
  'BackupInProgress': (type, message) =>
      BackupInProgress(type: type, message: message),
  'BackupNotFound': (type, message) =>
      BackupNotFound(type: type, message: message),
  'BackupRestoring': (type, message) =>
      BackupRestoring(type: type, message: message),
  'BadRequest': (type, message) => BadRequest(type: type, message: message),
  'DataRepositoryTaskEnded': (type, message) =>
      DataRepositoryTaskEnded(type: type, message: message),
  'DataRepositoryTaskExecuting': (type, message) =>
      DataRepositoryTaskExecuting(type: type, message: message),
  'DataRepositoryTaskNotFound': (type, message) =>
      DataRepositoryTaskNotFound(type: type, message: message),
  'FileSystemNotFound': (type, message) =>
      FileSystemNotFound(type: type, message: message),
  'IncompatibleParameterError': (type, message) =>
      IncompatibleParameterError(type: type, message: message),
  'InternalServerError': (type, message) =>
      InternalServerError(type: type, message: message),
  'InvalidExportPath': (type, message) =>
      InvalidExportPath(type: type, message: message),
  'InvalidImportPath': (type, message) =>
      InvalidImportPath(type: type, message: message),
  'InvalidNetworkSettings': (type, message) =>
      InvalidNetworkSettings(type: type, message: message),
  'InvalidPerUnitStorageThroughput': (type, message) =>
      InvalidPerUnitStorageThroughput(type: type, message: message),
  'MissingFileSystemConfiguration': (type, message) =>
      MissingFileSystemConfiguration(type: type, message: message),
  'NotServiceResourceError': (type, message) =>
      NotServiceResourceError(type: type, message: message),
  'ResourceDoesNotSupportTagging': (type, message) =>
      ResourceDoesNotSupportTagging(type: type, message: message),
  'ResourceNotFound': (type, message) =>
      ResourceNotFound(type: type, message: message),
  'ServiceLimitExceeded': (type, message) =>
      ServiceLimitExceeded(type: type, message: message),
  'UnsupportedOperation': (type, message) =>
      UnsupportedOperation(type: type, message: message),
};
