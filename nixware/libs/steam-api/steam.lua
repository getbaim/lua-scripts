local helper = require 'ffi_helper'

ffi.cdef[[
	typedef struct {
		void* steam_client; // 0
		void* steam_user; // 1
		void* steam_friends; // 2
		void* steam_utils; // 3
		void* steam_matchmaking; // 4
		void* steam_user_stats; // 5
		void* steam_apps; // 6
		void* steam_matchmakingservers; // 7
		void* steam_networking; // 8
		void* steam_remotestorage; // 9
		void* steam_screenshots; // 10
		void* steam_http; // 11		
        void* steam_unidentifiedmessages; // 12
        void* steam_controller; // 13
        void* steam_ugc; // 14
        void* steam_applist; // 15
        void* steam_music; // 16
        void* steam_musicremote; // 17
        void* steam_htmlsurface; // 18
        void* steam_inventory; // 19
        void* steam_video; // 20
    } steam_api_ctx_t;

    typedef unsigned char uint8;
    typedef uint16_t uint16;
    typedef uint32_t uint32;
    typedef uint64_t uint64;
    typedef signed char int8;
    typedef int16_t int16;
    typedef int32_t int32;
    typedef int64_t int64;

	typedef int EUniverse;
	typedef int ENotificationPosition;
	typedef int ESteamAPICallFailure;
	typedef int EGamepadTextInputMode;
	typedef int EGamepadTextInputLineMode;
	typedef int ELobbyComparison;
	typedef int ELobbyDistanceFilter;
	typedef int ELobbyType;
	typedef int EAccountType;
	typedef int EChatEntryType;
	typedef int EVoiceResult;
	typedef int EBeginAuthSessionResult;
	typedef int EUserHasLicenseForAppResult;
	typedef int ELeaderboardSortMethod;
	typedef int ELeaderboardDisplayType;
	typedef int ELeaderboardDataRequest;
	typedef int ELeaderboardUploadScoreMethod;
	typedef int EPersonaState;
	typedef int EFriendRelationship;
	typedef int EActivateGameOverlayToWebPageMode;
	typedef int EOverlayToStoreFlag;
	typedef int EP2PSend;
	typedef int ESNetSocketConnectionType;
	typedef int ERemoteStoragePlatform;
	typedef int EUGCReadAction;
	typedef int ERemoteStoragePublishedFileVisibility;
	typedef int EWorkshopFileType;
	typedef int EWorkshopVideoProvider;
	typedef int EWorkshopFileAction;
	typedef int EWorkshopEnumerationType;
	typedef int EVRScreenshotType;
	typedef int EHTTPMethod;
	typedef int EControllerActionOrigin;
	typedef int ESteamControllerPad;
	typedef int ESteamInputType;
	typedef int EXboxOrigin;
	typedef int EUserUGCList;
	typedef int EUGCMatchingUGCType;
	typedef int EUserUGCListSortOrder;
	typedef int EUGCQuery;
	typedef int EResult;
	typedef int EItemStatistic;
	typedef int EItemPreviewType;
	typedef int EItemUpdateStatus;
	typedef int AudioPlayback_Status;
	typedef int EHTMLMouseButton;
	typedef int EHTMLKeyModifiers;
	typedef int HServerQuery;

	typedef int16 FriendsGroupID_t;

	typedef int32 SteamInventoryResult_t;
	typedef int32 SteamItemDef_t;

	typedef uint32 HSteamPipe;
	typedef uint32 HSteamUser;
	typedef uint32 HAuthTicket;
	typedef uint32 HHTMLBrowser;
	typedef uint32 DepotId_t;
	typedef uint32 AccountID_t;
	typedef uint32 RTime32;
	typedef uint32 AppId_t;
	typedef uint32 SNetSocket_t;
	typedef uint32 SNetListenSocket_t;
	typedef uint32 ScreenshotHandle;
	typedef uint32 HTTPRequestHandle;
	typedef uint32 HTTPCookieContainerHandle;

	typedef uint64 SteamAPICall_t;
	typedef uint64 SteamLeaderboard_t;
	typedef uint64 SteamLeaderboardEntries_t;
	typedef uint64 UGCHandle_t;
	typedef uint64 UGCQueryHandle_t;
	typedef uint64 UGCUpdateHandle_t;
	typedef uint64 UGCFileWriteStreamHandle_t;
	typedef uint64 PublishedFileUpdateHandle_t;
	typedef uint64 PublishedFileId_t;
	typedef uint64 ControllerHandle_t;
	typedef uint64 ControllerActionSetHandle_t;
	typedef uint64 ControllerDigitalActionHandle_t;
	typedef uint64 ControllerAnalogActionHandle_t;
	typedef uint64 SteamItemInstanceID_t;
	typedef uint64 SteamInventoryUpdateHandle_t;

	typedef uint64 CSteamID;
	typedef uint64 CGameID;
	typedef void* HServerListRequest;
	typedef void* ISteamMatchmakingServerListResponse;
	typedef void* ISteamMatchmakingPingResponse;
	typedef void* ISteamMatchmakingPlayersResponse;
	typedef void* ISteamMatchmakingRulesResponse;
	typedef void* gameserveritem_t;
	typedef void* ISteamUser;
	typedef void* ISteamGameServer;
	typedef void* ISteamFriends;
	typedef void* ISteamUtils;
	typedef void* ISteamMatchmaking;
	typedef void* ISteamMatchmakingServers;
	typedef void* ISteamUserStats;
	typedef void* ISteamGameServerStats;
	typedef void* ISteamApps;
	typedef void* ISteamNetworking;
	typedef void* ISteamRemoteStorage;
	typedef void* ISteamScreenshots;
	typedef void* ISteamGameSearch;
	typedef void* ISteamHTTP;
	typedef void* ISteamController;
	typedef void* ISteamUGC;
	typedef void* ISteamAppList;
	typedef void* ISteamMusic;
	typedef void* ISteamMusicRemote;
	typedef void* ISteamHTMLSurface;
	typedef void* ISteamInventory;
	typedef void* ISteamVideo;
	typedef void* ISteamParentalSettings;
	typedef void* ISteamInput;
	typedef void* ISteamParties;

    typedef void (__cdecl *SteamAPIWarningMessageHook_t)(int, const char *);

    typedef struct _MatchMakingKeyValuePair_t
    {
        char m_szKey[ 256 ];
        char m_szValue[ 256 ];
    } MatchMakingKeyValuePair_t;

    typedef struct _FriendGameInfo_t
    {
    	CGameID m_gameID;
    	uint32 m_unGameIP;
    	uint16 m_usGamePort;
    	uint16 m_usQueryPort;
    	CSteamID m_steamIDLobby;
    } FriendGameInfo_t;

    typedef struct _P2PSessionState_t
    {
    	uint8 m_bConnectionActive;		
    	uint8 m_bConnecting;			
    	uint8 m_eP2PSessionError;		
    	uint8 m_bUsingRelay;			
    	int32 m_nBytesQueuedForSend;
    	int32 m_nPacketsQueuedForSend;
    	uint32 m_nRemoteIP;				
    	uint16 m_nRemotePort;			
    } P2PSessionState_t;

    typedef struct _SteamParamStringArray_t
    {
        const char ** m_ppStrings;
        int32 m_nNumStrings;
    } SteamParamStringArray_t;

    typedef struct _InputMotionData_t
    {
    	// Sensor-fused absolute rotation; will drift in heading
    	float rotQuatX;
    	float rotQuatY;
    	float rotQuatZ;
    	float rotQuatW;
    
    	// Positional acceleration
    	float posAccelX;
    	float posAccelY;
    	float posAccelZ;

    	// Angular velocity
    	float rotVelX;
    	float rotVelY;
    	float rotVelZ;
    } InputMotionData_t;

    typedef InputMotionData_t ControllerMotionData_t;

    typedef struct _SteamUGCDetails_t
    {
        PublishedFileId_t m_nPublishedFileId;
        EResult m_eResult;												// The result of the operation.	
        EWorkshopFileType m_eFileType;									// Type of the file
        AppId_t m_nCreatorAppID;										// ID of the app that created this file.
        AppId_t m_nConsumerAppID;										// ID of the app that will consume this file.
        char m_rgchTitle[129];				// title of document
        char m_rgchDescription[8000];	// description of document
        uint64 m_ulSteamIDOwner;										// Steam ID of the user who created this content.
        uint32 m_rtimeCreated;											// time when the published file was created
        uint32 m_rtimeUpdated;											// time when the published file was last updated
        uint32 m_rtimeAddedToUserList;									// time when the user added the published file to their list (not always applicable)
        ERemoteStoragePublishedFileVisibility m_eVisibility;			// visibility
        bool m_bBanned;													// whether the file was banned
        bool m_bAcceptedForUse;											// developer has specifically flagged this item as accepted in the Workshop
        bool m_bTagsTruncated;											// whether the list of tags was too long to be returned in the provided buffer
        char m_rgchTags[1025];								// comma separated list of all tags associated with this file	
        // file/url information
        UGCHandle_t m_hFile;											// The handle of the primary file
        UGCHandle_t m_hPreviewFile;										// The handle of the preview file
        char m_pchFileName[260];							// The cloud filename of the primary file
        int32 m_nFileSize;												// Size of the primary file
        int32 m_nPreviewFileSize;										// Size of the preview file
        char m_rgchURL[256];						// URL (for a video or a website)
        // voting information
        uint32 m_unVotesUp;												// number of votes up
        uint32 m_unVotesDown;											// number of votes down
        float m_flScore;												// calculated score
        // collection details
        uint32 m_unNumChildren;							
	} SteamUGCDetails_t;

	typedef struct _LeaderboardEntry_t 
	{
		CSteamID m_steamIDUser;
		int m_nGlobalRank;
		int m_nScore;
		int m_cDetails;
		UGCHandle_t m_hUGC;
	} LeaderboardEntry_t;

	typedef struct _ControllerDigitalActionData_t {
		unsigned char bState;
		unsigned char bActive;
	} ControllerDigitalActionData_t;

	typedef struct _ControllerAnalogActionData_t {
		unsigned char bActive;
		int eMode;
		float x;
		float y;
	} ControllerAnalogActionData_t;
]]

local steam_api = helper.find_pattern("client.dll", "FF 15 ? ? ? ? B9 ? ? ? ? E8 ? ? ? ? 6A", "steam_api_ctx_t**", 7)[0]

local api_mt = {}

local steam_client = helper.get_class(steam_api.steam_client)
local ISteamClient_mt = {
	raw = steam_client,
	CreateSteamPipe = steam_client:get_vfunc(0, 'HSteamPipe(__thiscall*)(void*)'),
	BReleaseSteamPipe = steam_client:get_vfunc(1, 'bool(__thiscall*)(void*, HSteamPipe)'),
	ConnectToGlobalUser = steam_client:get_vfunc(2, 'HSteamUser(__thiscall*)(void*, HSteamPipe)'),
	CreateLocalUser = steam_client:get_vfunc(3, 'HSteamUser(__thiscall*)(void*, HSteamPipe*, EAccountType)'),
	ReleaseUser = steam_client:get_vfunc(4, 'void(__thiscall*)(void*, HSteamPipe, HSteamUser)'),
	GetISteamUser = steam_client:get_vfunc(5, 'ISteamUser*(__thiscall*)(void*, HSteamUser, HSteamPipe, const char*)'),
	GetISteamGameServer = steam_client:get_vfunc(6, 'ISteamGameServer*(__thiscall*)(void*, HSteamUser, HSteamPipe, const char*)'),
	SetLocalIPBinding = steam_client:get_vfunc(7, 'void(__thiscall*)(void*, uint32, uint16)'),
	GetISteamFriends = steam_client:get_vfunc(8, 'ISteamFriends*(__thiscall*)(void*, HSteamUser, HSteamPipe, const char*)'),
	GetISteamUtils = steam_client:get_vfunc(9, 'ISteamUtils*(__thiscall*)(void*, HSteamPipe, const char*)'),
	GetISteamMatchmaking = steam_client:get_vfunc(10, 'ISteamMatchmaking*(__thiscall*)(void*, HSteamUser, HSteamPipe, const char*)'),
	GetISteamMatchmakingServers = steam_client:get_vfunc(11, 'ISteamMatchmakingServers*(__thiscall*)(void*, HSteamUser, HSteamPipe, const char*)'),
	GetISteamGenericInterface = steam_client:get_vfunc(12, 'void*(__thiscall*)(void*, HSteamUser, HSteamPipe, const char*)'),
	GetISteamUserStats = steam_client:get_vfunc(13, 'ISteamUserStats*(__thiscall*)(void*, HSteamUser, HSteamPipe, const char*)'),
	GetISteamGameServerStats = steam_client:get_vfunc(14, 'ISteamGameServerStats*(__thiscall*)(void*, HSteamUser, HSteamPipe, const char*)'),
	GetISteamApps = steam_client:get_vfunc(15, 'ISteamApps*(__thiscall*)(void*, HSteamUser, HSteamPipe, const char*)'),
	GetISteamNetworking = steam_client:get_vfunc(16, 'ISteamNetworking*(__thiscall*)(void*, HSteamUser, HSteamPipe, const char*)'),
	GetISteamRemoteStorage = steam_client:get_vfunc(17, 'ISteamRemoteStorage*(__thiscall*)(void*, HSteamUser, HSteamPipe, const char*)'),
	GetISteamScreenshots = steam_client:get_vfunc(18, 'ISteamScreenshots*(__thiscall*)(void*, HSteamUser, HSteamPipe, const char*)'),
	GetISteamGameSearch = steam_client:get_vfunc(19, 'ISteamGameSearch*(__thiscall*)(void*, HSteamUser, HSteamPipe, const char*)'),
	GetIPCCallCount = steam_client:get_vfunc(21, 'uint32(__thiscall*)(void*)'),
	SetWarningMessageHook = steam_client:get_vfunc(22, 'void(__thiscall*)(void*, SteamAPIWarningMessageHook_t)'),
	BShutdownIfAllPipesClosed = steam_client:get_vfunc(23, 'bool(__thiscall*)(void*)'),
	GetISteamHTTP = steam_client:get_vfunc(24, 'ISteamHTTP*(__thiscall*)(void*, HSteamUser, HSteamPipe, const char*)'),
	GetISteamController = steam_client:get_vfunc(26, 'ISteamController*(__thiscall*)(void*, HSteamUser, HSteamPipe, const char*)'),
	GetISteamUGC = steam_client:get_vfunc(27, 'ISteamUGC*(__thiscall*)(void*, HSteamUser, HSteamPipe, const char*)'),
	GetISteamAppList = steam_client:get_vfunc(28, 'ISteamAppList*(__thiscall*)(void*, HSteamUser, HSteamPipe, const char*)'),
	GetISteamMusic = steam_client:get_vfunc(29, 'ISteamMusic*(__thiscall*)(void*, HSteamUser, HSteamPipe, const char*)'),
	GetISteamMusicRemote = steam_client:get_vfunc(30, 'ISteamMusicRemote*(__thiscall*)(void*, HSteamUser, HSteamPipe, const char*)'),
	GetISteamHTMLSurface = steam_client:get_vfunc(31, 'ISteamHTMLSurface*(__thiscall*)(void*, HSteamUser, HSteamPipe, const char*)'),
	GetISteamInventory = steam_client:get_vfunc(35, 'ISteamInventory*(__thiscall*)(void*, HSteamUser, HSteamPipe, const char*)'),
	GetISteamVideo = steam_client:get_vfunc(36, 'ISteamVideo*(__thiscall*)(void*, HSteamUser, HSteamPipe, const char*)'),
	GetISteamParentalSettings = steam_client:get_vfunc(37, 'ISteamParentalSettings*(__thiscall*)(void*, HSteamUser, HSteamPipe, const char*)'),
	GetISteamInput = steam_client:get_vfunc(38, 'ISteamInput*(__thiscall*)(void*, HSteamUser, HSteamPipe, const char*)'),
	GetISteamParties = steam_client:get_vfunc(39, 'ISteamParties*(__thiscall*)(void*, HSteamUser, HSteamPipe, const char*)'),
}
api_mt.ISteamClient = ISteamClient_mt

local steam_utils = helper.get_class(steam_api.steam_utils)
local ISteamUtils_mt = {
	raw = steam_utils,
	GetSecondsSinceAppActive = steam_utils:get_vfunc(0, 'uint32(__thiscall*)(void*)'),
	GetSecondsSinceComputerActive = steam_utils:get_vfunc(1, 'uint32(__thiscall*)(void*)'),
	GetConnectedUniverse = steam_utils:get_vfunc(2, 'EUniverse(__thiscall*)(void*)'),
	GetServerRealTime = steam_utils:get_vfunc(3, 'uint32(__thiscall*)(void*)'),
	GetIPCountry = steam_utils:get_vfunc(4, 'const char*(__thiscall*)(void*)'),
	GetImageSize = steam_utils:get_vfunc(5, 'bool(__thiscall*)(void*, int, uint32*, uint32*)'),
	GetImageRGBA = steam_utils:get_vfunc(6, 'bool(__thiscall*)(void*, int, uint8*, int)'),
	GetCSERIPPort = steam_utils:get_vfunc(7, 'bool(__thiscall*)(void*, uint32*, uint16*)'),
	GetCurrentBatteryPower = steam_utils:get_vfunc(8, 'uint8(__thiscall*)(void*)'),
	GetAppID = steam_utils:get_vfunc(9, 'uint32(__thiscall*)(void*)'),
	SetOverlayNotificationPosition = steam_utils:get_vfunc(10, 'void(__thiscall*)(void*, ENotificationPosition)'),
	IsAPICallCompleted = steam_utils:get_vfunc(11, 'bool(__thiscall*)(void*, SteamAPICall_t, bool*)'),
	GetAPICallFailureReason = steam_utils:get_vfunc(12, 'ESteamAPICallFailure(__thiscall*)(void*, SteamAPICall_t)'),
	GetAPICallResult = steam_utils:get_vfunc(13, 'bool(__thiscall*)(void*, SteamAPICall_t, void*, int, int, bool*)'),
	GetIPCCallCount = steam_utils:get_vfunc(15, 'uint32(__thiscall*)(void*)'),
	SetWarningMessageHook = steam_utils:get_vfunc(16, 'void(__thiscall*)(void*, SteamAPIWarningMessageHook_t)'),
	IsOverlayEnabled = steam_utils:get_vfunc(17, 'bool(__thiscall*)(void*)'),
	BOverlayNeedsPresent = steam_utils:get_vfunc(18, 'bool(__thiscall*)(void*)'),
	CheckFileSignature = steam_utils:get_vfunc(19, 'SteamAPICall_t(__thiscall*)(void*, const char*)'),
	ShowGamepadTextInput = steam_utils:get_vfunc(20, 'bool(__thiscall*)(void*, EGamepadTextInputMode, EGamepadTextInputLineMode, const char*, uint32, const char*)'),
	GetEnteredGamepadTextLength = steam_utils:get_vfunc(21, 'uint32(__thiscall*)(void*)'),
	GetEnteredGamepadTextInput = steam_utils:get_vfunc(22, 'bool(__thiscall*)(void*, char*, uint32)'),
	GetSteamUILanguage = steam_utils:get_vfunc(23, 'const char*(__thiscall*)(void*)'),
	IsSteamRunningInVR = steam_utils:get_vfunc(24, 'bool(__thiscall*)(void*)'),
	SetOverlayNotificationInset = steam_utils:get_vfunc(25, 'void(__thiscall*)(void*, int, int)'),
	IsSteamInBigPictureMode = steam_utils:get_vfunc(26, 'bool(__thiscall*)(void*)'),
	StartVRDashboard = steam_utils:get_vfunc(27, 'void(__thiscall*)(void*)'),
	IsVRHeadsetStreamingEnabled = steam_utils:get_vfunc(28, 'bool(__thiscall*)(void*)'),
	SetVRHeadsetStreamingEnabled = steam_utils:get_vfunc(29, 'void(__thiscall*)(void*, bool)'),
}
api_mt.ISteamUtils = ISteamUtils_mt

local steam_matchmaking = helper.get_class(steam_api.steam_matchmaking)
local ISteamMatchmaking_mt = {
	raw = steam_matchmaking,
	GetFavoriteGame = steam_matchmaking:get_vfunc(0, 'bool(__thiscall*)(void*, int, AppId_t*, uint32*, uint16*, uint16*, uint32*, uint32*)'),
	AddFavoriteGame = steam_matchmaking:get_vfunc(1, 'int(__thiscall*)(void*, AppId_t, uint32, uint16, uint16, uint32, uint32)'),
	RemoveFavoriteGame = steam_matchmaking:get_vfunc(2, 'bool(__thiscall*)(void*, AppId_t, uint32, uint16, uint16, uint32)'),
	RequestLobbyList = steam_matchmaking:get_vfunc(3, 'SteamAPICall_t(__thiscall*)(void*)'),
	AddRequestLobbyListStringFilter = steam_matchmaking:get_vfunc(4, 'void(__thiscall*)(void*, const char*, const char*, ELobbyComparison)'),
	AddRequestLobbyListNumericalFilter = steam_matchmaking:get_vfunc(5, 'void(__thiscall*)(void*, const char*, int, ELobbyComparison)'),
	AddRequestLobbyListNearValueFilter = steam_matchmaking:get_vfunc(6, 'void(__thiscall*)(void*, const char*, int)'),
	AddRequestLobbyListFilterSlotsAvailable = steam_matchmaking:get_vfunc(7, 'void(__thiscall*)(void*, int)'),
	AddRequestLobbyListDistanceFilter = steam_matchmaking:get_vfunc(8, 'void(__thiscall*)(void*, ELobbyDistanceFilter)'),
	AddRequestLobbyListResultCountFilter = steam_matchmaking:get_vfunc(9, 'void(__thiscall*)(void*, int)'),
	AddRequestLobbyListCompatibleMembersFilter = steam_matchmaking:get_vfunc(10, 'void(__thiscall*)(void*, CSteamID)'),
	GetLobbyByIndex = steam_matchmaking:get_vfunc(11, 'CSteamID(__thiscall*)(void*, int)'),
	CreateLobby = steam_matchmaking:get_vfunc(12, 'SteamAPICall_t(__thiscall*)(void*, ELobbyType, int)'),
	JoinLobby = steam_matchmaking:get_vfunc(13, 'SteamAPICall_t(__thiscall*)(void*, CSteamID)'),
	LeaveLobby = steam_matchmaking:get_vfunc(14, 'void(__thiscall*)(void*, CSteamID)'),
	InviteUserToLobby = steam_matchmaking:get_vfunc(15, 'bool(__thiscall*)(void*, CSteamID, CSteamID)'),
	GetNumLobbyMembers = steam_matchmaking:get_vfunc(16, 'int(__thiscall*)(void*, CSteamID)'),
	GetLobbyMemberByIndex = steam_matchmaking:get_vfunc(17, 'CSteamID(__thiscall*)(void*, CSteamID, int)'),
	GetLobbyData = steam_matchmaking:get_vfunc(18, 'const char*(__thiscall*)(void*, CSteamID, const char*)'),
	SetLobbyData = steam_matchmaking:get_vfunc(19, 'bool(__thiscall*)(void*, CSteamID, const char*, const char*)'),
	GetLobbyDataCount = steam_matchmaking:get_vfunc(20, 'int(__thiscall*)(void*, CSteamID)'),
	GetLobbyDataByIndex = steam_matchmaking:get_vfunc(21, 'bool(__thiscall*)(void*, CSteamID, int, char*, int, char*, int)'),
	DeleteLobbyData = steam_matchmaking:get_vfunc(22, 'bool(__thiscall*)(void*, CSteamID, const char*)'),
	GetLobbyMemberData = steam_matchmaking:get_vfunc(23, 'const char*(__thiscall*)(void*, CSteamID, CSteamID, const char*)'),
	SetLobbyMemberData = steam_matchmaking:get_vfunc(24, 'void(__thiscall*)(void*, CSteamID, const char*, const char*)'),
	SendLobbyChatMsg = steam_matchmaking:get_vfunc(25, 'bool(__thiscall*)(void*, CSteamID, const void*, int)'),
	GetLobbyChatEntry = steam_matchmaking:get_vfunc(26, 'int(__thiscall*)(void*, CSteamID, int, CSteamID*, void*, int, EChatEntryType*)'),
	RequestLobbyData = steam_matchmaking:get_vfunc(27, 'bool(__thiscall*)(void*, CSteamID)'),
	SetLobbyGameServer = steam_matchmaking:get_vfunc(28, 'void(__thiscall*)(void*, CSteamID, uint32, uint16, CSteamID)'),
	GetLobbyGameServer = steam_matchmaking:get_vfunc(29, 'bool(__thiscall*)(void*, CSteamID, uint32*, uint16*, CSteamID*)'),
	SetLobbyMemberLimit = steam_matchmaking:get_vfunc(30, 'bool(__thiscall*)(void*, CSteamID, int)'),
	GetLobbyMemberLimit = steam_matchmaking:get_vfunc(31, 'int(__thiscall*)(void*, CSteamID)'),
	SetLobbyType = steam_matchmaking:get_vfunc(32, 'bool(__thiscall*)(void*, CSteamID, ELobbyType)'),
	SetLobbyJoinable = steam_matchmaking:get_vfunc(33, 'bool(__thiscall*)(void*, CSteamID, bool)'),
	GetLobbyOwner = steam_matchmaking:get_vfunc(34, 'CSteamID(__thiscall*)(void*, CSteamID)'),
	SetLobbyOwner = steam_matchmaking:get_vfunc(35, 'bool(__thiscall*)(void*, CSteamID, CSteamID)'),
	SetLinkedLobby = steam_matchmaking:get_vfunc(36, 'bool(__thiscall*)(void*, CSteamID, CSteamID)'),
}
api_mt.ISteamMatchmaking = ISteamMatchmaking_mt

local steam_user = helper.get_class(steam_api.steam_user)
local ISteamUser_mt = {
	raw = steam_user,
	GetHSteamUser = steam_user:get_vfunc(0, 'HSteamUser(__thiscall*)(void*)'),
	BLoggedOn = steam_user:get_vfunc(1, 'bool(__thiscall*)(void*)'),
	GetSteamID = steam_user:get_vfunc(2, 'CSteamID(__thiscall*)(void*)'),
	InitiateGameConnection = steam_user:get_vfunc(3, 'int(__thiscall*)(void*, void*, int, CSteamID, uint32, uint16, bool)'),
	TerminateGameConnection = steam_user:get_vfunc(4, 'void(__thiscall*)(void*, uint32, uint16)'),
	TrackAppUsageEvent = steam_user:get_vfunc(5, 'void(__thiscall*)(void*, CGameID, int, const char*)'),
	GetUserDataFolder = steam_user:get_vfunc(6, 'bool(__thiscall*)(void*, char*, int)'),
	StartVoiceRecording = steam_user:get_vfunc(7, 'void(__thiscall*)(void*)'),
	StopVoiceRecording = steam_user:get_vfunc(8, 'void(__thiscall*)(void*)'),
	GetAvailableVoice = steam_user:get_vfunc(9, 'EVoiceResult(__thiscall*)(void*, uint32*, uint32*, uint32)'),
	GetVoice = steam_user:get_vfunc(10, 'EVoiceResult(__thiscall*)(void*, bool, void*, uint32, uint32*, bool, void*, uint32, uint32*, uint32)'),
	DecompressVoice = steam_user:get_vfunc(11, 'EVoiceResult(__thiscall*)(void*, const void*, uint32, void*, uint32, uint32*, uint32)'),
	GetVoiceOptimalSampleRate = steam_user:get_vfunc(12, 'uint32(__thiscall*)(void*)'),
	GetAuthSessionTicket = steam_user:get_vfunc(13, 'HAuthTicket(__thiscall*)(void*, void*, int, uint32*)'),
	BeginAuthSession = steam_user:get_vfunc(14, 'EBeginAuthSessionResult(__thiscall*)(void*, const void*, int, CSteamID)'),
	EndAuthSession = steam_user:get_vfunc(15, 'void(__thiscall*)(void*, CSteamID)'),
	CancelAuthTicket = steam_user:get_vfunc(16, 'void(__thiscall*)(void*, HAuthTicket)'),
	UserHasLicenseForApp = steam_user:get_vfunc(17, 'EUserHasLicenseForAppResult(__thiscall*)(void*, CSteamID, AppId_t)'),
	BIsBehindNAT = steam_user:get_vfunc(18, 'bool(__thiscall*)(void*)'),
	AdvertiseGame = steam_user:get_vfunc(19, 'void(__thiscall*)(void*, CSteamID, uint32, uint16)'),
	RequestEncryptedAppTicket = steam_user:get_vfunc(20, 'SteamAPICall_t(__thiscall*)(void*, void*, int)'),
	GetEncryptedAppTicket = steam_user:get_vfunc(21, 'bool(__thiscall*)(void*, void*, int, uint32*)'),
	GetGameBadgeLevel = steam_user:get_vfunc(22, 'int(__thiscall*)(void*, int, bool)'),
	GetPlayerSteamLevel = steam_user:get_vfunc(23, 'int(__thiscall*)(void*)'),
	RequestStoreAuthURL = steam_user:get_vfunc(24, 'SteamAPICall_t(__thiscall*)(void*, const char*)'),
	BIsPhoneVerified = steam_user:get_vfunc(25, 'bool(__thiscall*)(void*)'),
	BIsTwoFactorEnabled = steam_user:get_vfunc(26, 'bool(__thiscall*)(void*)'),
	BIsPhoneIdentifying = steam_user:get_vfunc(27, 'bool(__thiscall*)(void*)'),
	BIsPhoneRequiringVerification = steam_user:get_vfunc(28, 'bool(__thiscall*)(void*)'),
	GetMarketEligibility = steam_user:get_vfunc(29, 'SteamAPICall_t(__thiscall*)(void*)'),
}
api_mt.ISteamUser = ISteamUser_mt

local steam_user_stats = helper.get_class(steam_api.steam_user_stats)
local ISteamUserStats_mt = {
	raw = steam_user_stats,
	RequestCurrentStats = steam_user_stats:get_vfunc(0, 'bool(__thiscall*)(void*)'),
	GetStatFloat = steam_user_stats:get_vfunc(1, 'bool(__thiscall*)(void*, const char*, float*)'),
	GetStatInt = steam_user_stats:get_vfunc(2, 'bool(__thiscall*)(void*, const char*, int32*)'),
	SetStatFloat = steam_user_stats:get_vfunc(3, 'bool(__thiscall*)(void*, const char*, float)'),
	SetStatInt = steam_user_stats:get_vfunc(4, 'bool(__thiscall*)(void*, const char*, int32)'),
	UpdateAvgRateStat = steam_user_stats:get_vfunc(5, 'bool(__thiscall*)(void*, const char*, float, double)'),
	GetAchievement = steam_user_stats:get_vfunc(6, 'bool(__thiscall*)(void*, const char*, bool*)'),
	SetAchievement = steam_user_stats:get_vfunc(7, 'bool(__thiscall*)(void*, const char*)'),
	ClearAchievement = steam_user_stats:get_vfunc(8, 'bool(__thiscall*)(void*, const char*)'),
	GetAchievementAndUnlockTime = steam_user_stats:get_vfunc(9, 'bool(__thiscall*)(void*, const char*, bool*, uint32*)'),
	StoreStats = steam_user_stats:get_vfunc(10, 'bool(__thiscall*)(void*)'),
	GetAchievementIcon = steam_user_stats:get_vfunc(11, 'int(__thiscall*)(void*, const char*)'),
	GetAchievementDisplayAttribute = steam_user_stats:get_vfunc(12, 'const char*(__thiscall*)(void*, const char*, const char*)'),
	IndicateAchievementProgress = steam_user_stats:get_vfunc(13, 'bool(__thiscall*)(void*, const char*, uint32, uint32)'),
	GetNumAchievements = steam_user_stats:get_vfunc(14, 'uint32(__thiscall*)(void*)'),
	GetAchievementName = steam_user_stats:get_vfunc(15, 'const char*(__thiscall*)(void*, uint32)'),
	RequestUserStats = steam_user_stats:get_vfunc(16, 'SteamAPICall_t(__thiscall*)(void*, CSteamID)'),
	GetUserStatFloat = steam_user_stats:get_vfunc(17, 'bool(__thiscall*)(void*, CSteamID, const char*, float*)'),
	GetUserStatInt = steam_user_stats:get_vfunc(18, 'bool(__thiscall*)(void*, CSteamID, const char*, int32*)'),
	GetUserAchievement = steam_user_stats:get_vfunc(19, 'bool(__thiscall*)(void*, CSteamID, const char*, bool*)'),
	GetUserAchievementAndUnlockTime = steam_user_stats:get_vfunc(20, 'bool(__thiscall*)(void*, CSteamID, const char*, bool*, uint32*)'),
	ResetAllStats = steam_user_stats:get_vfunc(21, 'bool(__thiscall*)(void*, bool)'),
	FindOrCreateLeaderboard = steam_user_stats:get_vfunc(22, 'SteamAPICall_t(__thiscall*)(void*, const char*, ELeaderboardSortMethod, ELeaderboardDisplayType)'),
	FindLeaderboard = steam_user_stats:get_vfunc(23, 'SteamAPICall_t(__thiscall*)(void*, const char*)'),
	GetLeaderboardName = steam_user_stats:get_vfunc(24, 'const char*(__thiscall*)(void*, SteamLeaderboard_t)'),
	GetLeaderboardEntryCount = steam_user_stats:get_vfunc(25, 'int(__thiscall*)(void*, SteamLeaderboard_t)'),
	GetLeaderboardSortMethod = steam_user_stats:get_vfunc(26, 'ELeaderboardSortMethod(__thiscall*)(void*, SteamLeaderboard_t)'),
	GetLeaderboardDisplayType = steam_user_stats:get_vfunc(27, 'ELeaderboardDisplayType(__thiscall*)(void*, SteamLeaderboard_t)'),
	DownloadLeaderboardEntries = steam_user_stats:get_vfunc(28, 'SteamAPICall_t(__thiscall*)(void*, SteamLeaderboard_t, ELeaderboardDataRequest, int, int)'),
	DownloadLeaderboardEntriesForUsers = steam_user_stats:get_vfunc(29, 'SteamAPICall_t(__thiscall*)(void*, SteamLeaderboard_t)'),
	GetDownloadedLeaderboardEntry = steam_user_stats:get_vfunc(30, 'bool(__thiscall*)(void*, SteamLeaderboardEntries_t, int, LeaderboardEntry_t*, int32*, int)'),
	UploadLeaderboardScore = steam_user_stats:get_vfunc(31, 'SteamAPICall_t(__thiscall*)(void*, SteamLeaderboard_t, ELeaderboardUploadScoreMethod, int32, const int32*, int)'),
	AttachLeaderboardUGC = steam_user_stats:get_vfunc(32, 'SteamAPICall_t(__thiscall*)(void*, SteamLeaderboard_t, UGCHandle_t)'),
	GetNumberOfCurrentPlayers = steam_user_stats:get_vfunc(33, 'SteamAPICall_t(__thiscall*)(void*)'),
	RequestGlobalAchievementPercentages = steam_user_stats:get_vfunc(34, 'SteamAPICall_t(__thiscall*)(void*)'),
	GetMostAchievedAchievementInfo = steam_user_stats:get_vfunc(35, 'int(__thiscall*)(void*, char*, uint32, float*, bool*)'),
	GetNextMostAchievedAchievementInfo = steam_user_stats:get_vfunc(36, 'int(__thiscall*)(void*, int, char*, uint32, float*, bool*)'),
	GetAchievementAchievedPercent = steam_user_stats:get_vfunc(37, 'bool(__thiscall*)(void*, const char*, float*)'),
	RequestGlobalStats = steam_user_stats:get_vfunc(38, 'SteamAPICall_t(__thiscall*)(void*, int)'),
	GetGlobalStatDouble = steam_user_stats:get_vfunc(39, 'bool(__thiscall*)(void*, const char*, double*)'),
	GetGlobalStatInt64 = steam_user_stats:get_vfunc(40, 'bool(__thiscall*)(void*, const char*, int64*)'),
	GetGlobalStatHistoryDouble = steam_user_stats:get_vfunc(41, 'int32(__thiscall*)(void*, const char*, double*, uint32)'),
	GetGlobalStatHistoryInt64 = steam_user_stats:get_vfunc(42, 'int32(__thiscall*)(void*, const char*, int64*, uint32)'),
}
api_mt.ISteamUserStats = ISteamUserStats_mt

local steam_friends = helper.get_class(steam_api.steam_friends)
local ISteamFriends_mt = {
	raw = steam_friends,
	GetPersonaName = steam_friends:get_vfunc(0, 'const char*(__thiscall*)(void*)'),
	SetPersonaName = steam_friends:get_vfunc(1, 'SteamAPICall_t(__thiscall*)(void*, const char*)'),
	GetPersonaState = steam_friends:get_vfunc(2, 'EPersonaState(__thiscall*)(void*)'),
	GetFriendCount = steam_friends:get_vfunc(3, 'int(__thiscall*)(void*, int)'),
	GetFriendByIndex = steam_friends:get_vfunc(4, 'CSteamID(__thiscall*)(void*, int, int)'),
	GetFriendRelationship = steam_friends:get_vfunc(5, 'EFriendRelationship(__thiscall*)(void*, CSteamID)'),
	GetFriendPersonaState = steam_friends:get_vfunc(6, 'EPersonaState(__thiscall*)(void*, CSteamID)'),
	GetFriendPersonaName = steam_friends:get_vfunc(7, 'const char*(__thiscall*)(void*, CSteamID)'),
	GetFriendGamePlayed = steam_friends:get_vfunc(8, 'bool(__thiscall*)(void*, CSteamID, FriendGameInfo_t*)'),
	GetFriendPersonaNameHistory = steam_friends:get_vfunc(9, 'const char*(__thiscall*)(void*, CSteamID, int)'),
	GetFriendSteamLevel = steam_friends:get_vfunc(10, 'int(__thiscall*)(void*, CSteamID)'),
	GetPlayerNickname = steam_friends:get_vfunc(11, 'const char*(__thiscall*)(void*, CSteamID)'),
	GetFriendsGroupCount = steam_friends:get_vfunc(12, 'int(__thiscall*)(void*)'),
	GetFriendsGroupIDByIndex = steam_friends:get_vfunc(13, 'FriendsGroupID_t(__thiscall*)(void*, int)'),
	GetFriendsGroupName = steam_friends:get_vfunc(14, 'const char*(__thiscall*)(void*, FriendsGroupID_t)'),
	GetFriendsGroupMembersCount = steam_friends:get_vfunc(15, 'int(__thiscall*)(void*, FriendsGroupID_t)'),
	GetFriendsGroupMembersList = steam_friends:get_vfunc(16, 'void(__thiscall*)(void*, FriendsGroupID_t, CSteamID*, int)'),
	HasFriend = steam_friends:get_vfunc(17, 'bool(__thiscall*)(void*, CSteamID, int)'),
	GetClanCount = steam_friends:get_vfunc(18, 'int(__thiscall*)(void*)'),
	GetClanByIndex = steam_friends:get_vfunc(19, 'CSteamID(__thiscall*)(void*, int)'),
	GetClanName = steam_friends:get_vfunc(20, 'const char*(__thiscall*)(void*, CSteamID)'),
	GetClanTag = steam_friends:get_vfunc(21, 'const char*(__thiscall*)(void*, CSteamID)'),
	GetClanActivityCounts = steam_friends:get_vfunc(22, 'bool(__thiscall*)(void*, CSteamID, int*, int*, int*)'),
	DownloadClanActivityCounts = steam_friends:get_vfunc(23, 'SteamAPICall_t(__thiscall*)(void*, CSteamID*, int)'),
	GetFriendCountFromSource = steam_friends:get_vfunc(24, 'int(__thiscall*)(void*, CSteamID)'),
	GetFriendFromSourceByIndex = steam_friends:get_vfunc(25, 'CSteamID(__thiscall*)(void*, CSteamID, int)'),
	IsUserInSource = steam_friends:get_vfunc(26, 'bool(__thiscall*)(void*, CSteamID, CSteamID)'),
	SetInGameVoiceSpeaking = steam_friends:get_vfunc(27, 'void(__thiscall*)(void*, CSteamID, bool)'),
	ActivateGameOverlay = steam_friends:get_vfunc(28, 'void(__thiscall*)(void*, const char*)'),
	ActivateGameOverlayToUser = steam_friends:get_vfunc(29, 'void(__thiscall*)(void*, const char*, CSteamID)'),
	ActivateGameOverlayToWebPage = steam_friends:get_vfunc(30, 'void(__thiscall*)(void*, const char*, EActivateGameOverlayToWebPageMode)'),
	ActivateGameOverlayToStore = steam_friends:get_vfunc(31, 'void(__thiscall*)(void*, AppId_t, EOverlayToStoreFlag)'),
	SetPlayedWith = steam_friends:get_vfunc(32, 'void(__thiscall*)(void*, CSteamID)'),
	ActivateGameOverlayInviteDialog = steam_friends:get_vfunc(33, 'void(__thiscall*)(void*, CSteamID)'),
	GetSmallFriendAvatar = steam_friends:get_vfunc(34, 'int(__thiscall*)(void*, CSteamID)'),
	GetMediumFriendAvatar = steam_friends:get_vfunc(35, 'int(__thiscall*)(void*, CSteamID)'),
	GetLargeFriendAvatar = steam_friends:get_vfunc(36, 'int(__thiscall*)(void*, CSteamID)'),
	RequestUserInformation = steam_friends:get_vfunc(37, 'bool(__thiscall*)(void*, CSteamID, bool)'),
	RequestClanOfficerList = steam_friends:get_vfunc(38, 'SteamAPICall_t(__thiscall*)(void*, CSteamID)'),
	GetClanOwner = steam_friends:get_vfunc(39, 'CSteamID(__thiscall*)(void*, CSteamID)'),
	GetClanOfficerCount = steam_friends:get_vfunc(40, 'int(__thiscall*)(void*, CSteamID)'),
	GetClanOfficerByIndex = steam_friends:get_vfunc(41, 'CSteamID(__thiscall*)(void*, CSteamID, int)'),
	GetUserRestrictions = steam_friends:get_vfunc(42, 'uint32(__thiscall*)(void*)'),
	SetRichPresence = steam_friends:get_vfunc(43, 'bool(__thiscall*)(void*, const char*, const char*)'),
	ClearRichPresence = steam_friends:get_vfunc(44, 'void(__thiscall*)(void*)'),
	GetFriendRichPresence = steam_friends:get_vfunc(45, 'const char*(__thiscall*)(void*, CSteamID, const char*)'),
	GetFriendRichPresenceKeyCount = steam_friends:get_vfunc(46, 'int(__thiscall*)(void*, CSteamID)'),
	GetFriendRichPresenceKeyByIndex = steam_friends:get_vfunc(47, 'const char*(__thiscall*)(void*, CSteamID, int)'),
	RequestFriendRichPresence = steam_friends:get_vfunc(48, 'void(__thiscall*)(void*, CSteamID)'),
	InviteUserToGame = steam_friends:get_vfunc(49, 'bool(__thiscall*)(void*, CSteamID, const char*)'),
	GetCoplayFriendCount = steam_friends:get_vfunc(50, 'int(__thiscall*)(void*)'),
	GetCoplayFriend = steam_friends:get_vfunc(51, 'CSteamID(__thiscall*)(void*, int)'),
	GetFriendCoplayTime = steam_friends:get_vfunc(52, 'int(__thiscall*)(void*, CSteamID)'),
	GetFriendCoplayGame = steam_friends:get_vfunc(53, 'AppId_t(__thiscall*)(void*, CSteamID)'),
	JoinClanChatRoom = steam_friends:get_vfunc(54, 'SteamAPICall_t(__thiscall*)(void*, CSteamID)'),
	LeaveClanChatRoom = steam_friends:get_vfunc(55, 'bool(__thiscall*)(void*, CSteamID)'),
	GetClanChatMemberCount = steam_friends:get_vfunc(56, 'int(__thiscall*)(void*, CSteamID)'),
	GetChatMemberByIndex = steam_friends:get_vfunc(57, 'CSteamID(__thiscall*)(void*, CSteamID, int)'),
	SendClanChatMessage = steam_friends:get_vfunc(58, 'bool(__thiscall*)(void*, CSteamID, const char*)'),
	GetClanChatMessage = steam_friends:get_vfunc(59, 'int(__thiscall*)(void*, CSteamID, int, void*, int, EChatEntryType*, CSteamID*)'),
	IsClanChatAdmin = steam_friends:get_vfunc(60, 'bool(__thiscall*)(void*, CSteamID, CSteamID)'),
	IsClanChatWindowOpenInSteam = steam_friends:get_vfunc(61, 'bool(__thiscall*)(void*, CSteamID)'),
	OpenClanChatWindowInSteam = steam_friends:get_vfunc(62, 'bool(__thiscall*)(void*, CSteamID)'),
	CloseClanChatWindowInSteam = steam_friends:get_vfunc(63, 'bool(__thiscall*)(void*, CSteamID)'),
	SetListenForFriendsMessages = steam_friends:get_vfunc(64, 'bool(__thiscall*)(void*, bool)'),
	ReplyToFriendMessage = steam_friends:get_vfunc(65, 'bool(__thiscall*)(void*, CSteamID, const char*)'),
	GetFriendMessage = steam_friends:get_vfunc(66, 'int(__thiscall*)(void*, CSteamID, int, void*, int, EChatEntryType*)'),
	GetFollowerCount = steam_friends:get_vfunc(67, 'SteamAPICall_t(__thiscall*)(void*, CSteamID)'),
	IsFollowing = steam_friends:get_vfunc(68, 'SteamAPICall_t(__thiscall*)(void*, CSteamID)'),
	EnumerateFollowingList = steam_friends:get_vfunc(69, 'SteamAPICall_t(__thiscall*)(void*, uint32)'),
	IsClanPublic = steam_friends:get_vfunc(70, 'bool(__thiscall*)(void*, CSteamID)'),
	IsClanOfficialGameGroup = steam_friends:get_vfunc(71, 'bool(__thiscall*)(void*, CSteamID)'),
	GetNumChatsWithUnreadPriorityMessages = steam_friends:get_vfunc(72, 'int(__thiscall*)(void*)'),
}
api_mt.ISteamFriends = ISteamFriends_mt

local steam_apps = helper.get_class(steam_api.steam_apps)
local ISteamApps_mt = {
	raw = steam_apps,
	BIsSubscribed = steam_apps:get_vfunc(0, 'bool(__thiscall*)(void*)'),
	BIsLowViolence = steam_apps:get_vfunc(1, 'bool(__thiscall*)(void*)'),
	BIsCybercafe = steam_apps:get_vfunc(2, 'bool(__thiscall*)(void*)'),
	BIsVACBanned = steam_apps:get_vfunc(3, 'bool(__thiscall*)(void*)'),
	GetCurrentGameLanguage = steam_apps:get_vfunc(4, 'const char*(__thiscall*)(void*)'),
	GetAvailableGameLanguages = steam_apps:get_vfunc(5, 'const char*(__thiscall*)(void*)'),
	BIsSubscribedApp = steam_apps:get_vfunc(6, 'bool(__thiscall*)(void*, AppId_t)'),
	BIsDlcInstalled = steam_apps:get_vfunc(7, 'bool(__thiscall*)(void*, AppId_t)'),
	GetEarliestPurchaseUnixTime = steam_apps:get_vfunc(8, 'uint32(__thiscall*)(void*, AppId_t)'),
	BIsSubscribedFromFreeWeekend = steam_apps:get_vfunc(9, 'bool(__thiscall*)(void*)'),
	GetDLCCount = steam_apps:get_vfunc(10, 'int(__thiscall*)(void*)'),
	BGetDLCDataByIndex = steam_apps:get_vfunc(11, 'bool(__thiscall*)(void*, int, AppId_t*, bool*, char*, int)'),
	InstallDLC = steam_apps:get_vfunc(12, 'void(__thiscall*)(void*, AppId_t)'),
	UninstallDLC = steam_apps:get_vfunc(13, 'void(__thiscall*)(void*, AppId_t)'),
	RequestAppProofOfPurchaseKey = steam_apps:get_vfunc(14, 'void(__thiscall*)(void*, AppId_t)'),
	GetCurrentBetaName = steam_apps:get_vfunc(15, 'bool(__thiscall*)(void*, char*, int)'),
	MarkContentCorrupt = steam_apps:get_vfunc(16, 'bool(__thiscall*)(void*, bool)'),
	GetInstalledDepots = steam_apps:get_vfunc(17, 'uint32(__thiscall*)(void*, AppId_t, DepotId_t*, uint32)'),
	GetAppInstallDir = steam_apps:get_vfunc(18, 'uint32(__thiscall*)(void*, AppId_t, char*, uint32)'),
	BIsAppInstalled = steam_apps:get_vfunc(19, 'bool(__thiscall*)(void*, AppId_t)'),
	GetAppOwner = steam_apps:get_vfunc(20, 'CSteamID(__thiscall*)(void*)'),
	GetLaunchQueryParam = steam_apps:get_vfunc(21, 'const char*(__thiscall*)(void*, const char*)'),
	GetDlcDownloadProgress = steam_apps:get_vfunc(22, 'bool(__thiscall*)(void*, AppId_t, uint64*, uint64*)'),
	GetAppBuildId = steam_apps:get_vfunc(23, 'int(__thiscall*)(void*)'),
	RequestAllProofOfPurchaseKeys = steam_apps:get_vfunc(24, 'void(__thiscall*)(void*)'),
	GetFileDetails = steam_apps:get_vfunc(25, 'SteamAPICall_t(__thiscall*)(void*, const char*)'),
	GetLaunchCommandLine = steam_apps:get_vfunc(26, 'int(__thiscall*)(void*, char*, int)'),
	BIsSubscribedFromFamilySharing = steam_apps:get_vfunc(27, 'bool(__thiscall*)(void*)'),
}
api_mt.ISteamApps = ISteamApps_mt

local steam_matchmakingservers = helper.get_class(steam_api.steam_matchmakingservers)
local ISteamMatchmakingServers_mt = {
	raw = steam_matchmakingservers,
	RequestInternetServerList = steam_matchmakingservers:get_vfunc(0, 'HServerListRequest(__thiscall*)(void*, AppId_t, MatchMakingKeyValuePair_t*, uint32, ISteamMatchmakingServerListResponse*)'),
	RequestLANServerList = steam_matchmakingservers:get_vfunc(1, 'HServerListRequest(__thiscall*)(void*, AppId_t, ISteamMatchmakingServerListResponse*)'),
	RequestFriendsServerList = steam_matchmakingservers:get_vfunc(2, 'HServerListRequest(__thiscall*)(void*, AppId_t, MatchMakingKeyValuePair_t*, uint32, ISteamMatchmakingServerListResponse*)'),
	RequestFavoritesServerList = steam_matchmakingservers:get_vfunc(3, 'HServerListRequest(__thiscall*)(void*, AppId_t, MatchMakingKeyValuePair_t*, uint32, ISteamMatchmakingServerListResponse*)'),
	RequestHistoryServerList = steam_matchmakingservers:get_vfunc(4, 'HServerListRequest(__thiscall*)(void*, AppId_t, MatchMakingKeyValuePair_t*, uint32, ISteamMatchmakingServerListResponse*)'),
	RequestSpectatorServerList = steam_matchmakingservers:get_vfunc(5, 'HServerListRequest(__thiscall*)(void*, AppId_t, MatchMakingKeyValuePair_t*, uint32, ISteamMatchmakingServerListResponse*)'),
	ReleaseRequest = steam_matchmakingservers:get_vfunc(6, 'void(__thiscall*)(void*, HServerListRequest)'),
	GetServerDetails = steam_matchmakingservers:get_vfunc(7, 'gameserveritem_t*(__thiscall*)(void*, HServerListRequest, int)'),
	CancelQuery = steam_matchmakingservers:get_vfunc(8, 'void(__thiscall*)(void*, HServerListRequest)'),
	RefreshQuery = steam_matchmakingservers:get_vfunc(9, 'void(__thiscall*)(void*, HServerListRequest)'),
	IsRefreshing = steam_matchmakingservers:get_vfunc(10, 'bool(__thiscall*)(void*, HServerListRequest)'),
	GetServerCount = steam_matchmakingservers:get_vfunc(11, 'int(__thiscall*)(void*, HServerListRequest)'),
	RefreshServer = steam_matchmakingservers:get_vfunc(12, 'void(__thiscall*)(void*, HServerListRequest, int)'),
	PingServer = steam_matchmakingservers:get_vfunc(13, 'HServerQuery(__thiscall*)(void*, uint32, uint16, ISteamMatchmakingPingResponse*)'),
	PlayerDetails = steam_matchmakingservers:get_vfunc(14, 'HServerQuery(__thiscall*)(void*, uint32, uint16, ISteamMatchmakingPlayersResponse*)'),
	ServerRules = steam_matchmakingservers:get_vfunc(15, 'HServerQuery(__thiscall*)(void*, uint32, uint16, ISteamMatchmakingRulesResponse*)'),
	CancelServerQuery = steam_matchmakingservers:get_vfunc(16, 'void(__thiscall*)(void*, HServerQuery)'),
}
api_mt.ISteamMatchmakingServers = ISteamMatchmakingServers_mt

local steam_networking = helper.get_class(steam_api.steam_networking)
local ISteamNetworking_mt = {
	raw = steam_networking,
	SendP2PPacket = steam_networking:get_vfunc(0, 'bool(__thiscall*)(void*, CSteamID, const void*, uint32, EP2PSend, int)'),
	IsP2PPacketAvailable = steam_networking:get_vfunc(1, 'bool(__thiscall*)(void*, uint32*, int)'),
	ReadP2PPacket = steam_networking:get_vfunc(2, 'bool(__thiscall*)(void*, void*, uint32, uint32*, CSteamID*, int)'),
	AcceptP2PSessionWithUser = steam_networking:get_vfunc(3, 'bool(__thiscall*)(void*, CSteamID)'),
	CloseP2PSessionWithUser = steam_networking:get_vfunc(4, 'bool(__thiscall*)(void*, CSteamID)'),
	CloseP2PChannelWithUser = steam_networking:get_vfunc(5, 'bool(__thiscall*)(void*, CSteamID, int)'),
	GetP2PSessionState = steam_networking:get_vfunc(6, 'bool(__thiscall*)(void*, CSteamID, P2PSessionState_t*)'),
	AllowP2PPacketRelay = steam_networking:get_vfunc(7, 'bool(__thiscall*)(void*, bool)'),
	CreateListenSocket = steam_networking:get_vfunc(8, 'SNetListenSocket_t(__thiscall*)(void*, int, uint32, uint16, bool)'),
	CreateP2PConnectionSocket = steam_networking:get_vfunc(9, 'SNetSocket_t(__thiscall*)(void*, CSteamID, int, int, bool)'),
	CreateConnectionSocket = steam_networking:get_vfunc(10, 'SNetSocket_t(__thiscall*)(void*, uint32, uint16, int)'),
	DestroySocket = steam_networking:get_vfunc(11, 'bool(__thiscall*)(void*, SNetSocket_t, bool)'),
	DestroyListenSocket = steam_networking:get_vfunc(12, 'bool(__thiscall*)(void*, SNetListenSocket_t, bool)'),
	SendDataOnSocket = steam_networking:get_vfunc(13, 'bool(__thiscall*)(void*, SNetSocket_t, void*, uint32, bool)'),
	IsDataAvailableOnSocket = steam_networking:get_vfunc(14, 'bool(__thiscall*)(void*, SNetSocket_t, uint32*)'),
	RetrieveDataFromSocket = steam_networking:get_vfunc(15, 'bool(__thiscall*)(void*, SNetSocket_t, void*, uint32, uint32*)'),
	IsDataAvailable = steam_networking:get_vfunc(16, 'bool(__thiscall*)(void*, SNetListenSocket_t, uint32*, SNetSocket_t*)'),
	RetrieveData = steam_networking:get_vfunc(17, 'bool(__thiscall*)(void*, SNetListenSocket_t, void*, uint32, uint32*, SNetSocket_t*)'),
	GetSocketInfo = steam_networking:get_vfunc(18, 'bool(__thiscall*)(void*, SNetSocket_t, CSteamID*, int*, uint32*, uint16*)'),
	GetListenSocketInfo = steam_networking:get_vfunc(19, 'bool(__thiscall*)(void*, SNetListenSocket_t, uint32*, uint16*)'),
	GetSocketConnectionType = steam_networking:get_vfunc(20, 'ESNetSocketConnectionType(__thiscall*)(void*, SNetSocket_t)'),
	GetMaxPacketSize = steam_networking:get_vfunc(21, 'int(__thiscall*)(void*, SNetSocket_t)'),
}
api_mt.ISteamNetworking = ISteamNetworking_mt

local steam_remotestorage = helper.get_class(steam_api.steam_remotestorage)
local ISteamRemoteStorage_mt = {
	raw = steam_remotestorage,
	FileWrite = steam_remotestorage:get_vfunc(0, 'bool(__thiscall*)(void*, const char*, const void*, int32)'),
	FileRead = steam_remotestorage:get_vfunc(1, 'int32(__thiscall*)(void*, const char*, void*, int32)'),
	FileWriteAsync = steam_remotestorage:get_vfunc(2, 'SteamAPICall_t(__thiscall*)(void*, const char*, const void*, uint32)'),
	FileReadAsync = steam_remotestorage:get_vfunc(3, 'SteamAPICall_t(__thiscall*)(void*, const char*, uint32, uint32)'),
	FileReadAsyncComplete = steam_remotestorage:get_vfunc(4, 'bool(__thiscall*)(void*, SteamAPICall_t, void*, uint32)'),
	FileForget = steam_remotestorage:get_vfunc(5, 'bool(__thiscall*)(void*, const char*)'),
	FileDelete = steam_remotestorage:get_vfunc(6, 'bool(__thiscall*)(void*, const char*)'),
	FileShare = steam_remotestorage:get_vfunc(7, 'SteamAPICall_t(__thiscall*)(void*, const char*)'),
	SetSyncPlatforms = steam_remotestorage:get_vfunc(8, 'bool(__thiscall*)(void*, const char*, ERemoteStoragePlatform)'),
	FileWriteStreamOpen = steam_remotestorage:get_vfunc(9, 'UGCFileWriteStreamHandle_t(__thiscall*)(void*, const char*)'),
	FileWriteStreamWriteChunk = steam_remotestorage:get_vfunc(10, 'bool(__thiscall*)(void*, UGCFileWriteStreamHandle_t, const void*, int32)'),
	FileWriteStreamClose = steam_remotestorage:get_vfunc(11, 'bool(__thiscall*)(void*, UGCFileWriteStreamHandle_t)'),
	FileWriteStreamCancel = steam_remotestorage:get_vfunc(12, 'bool(__thiscall*)(void*, UGCFileWriteStreamHandle_t)'),
	FileExists = steam_remotestorage:get_vfunc(13, 'bool(__thiscall*)(void*, const char*)'),
	FilePersisted = steam_remotestorage:get_vfunc(14, 'bool(__thiscall*)(void*, const char*)'),
	GetFileSize = steam_remotestorage:get_vfunc(15, 'int32(__thiscall*)(void*, const char*)'),
	GetFileTimestamp = steam_remotestorage:get_vfunc(16, 'int64(__thiscall*)(void*, const char*)'),
	GetSyncPlatforms = steam_remotestorage:get_vfunc(17, 'ERemoteStoragePlatform(__thiscall*)(void*, const char*)'),
	GetFileCount = steam_remotestorage:get_vfunc(18, 'int32(__thiscall*)(void*)'),
	GetFileNameAndSize = steam_remotestorage:get_vfunc(19, 'const char*(__thiscall*)(void*, int, int32*)'),
	GetQuota = steam_remotestorage:get_vfunc(20, 'bool(__thiscall*)(void*, uint64*, uint64*)'),
	IsCloudEnabledForAccount = steam_remotestorage:get_vfunc(21, 'bool(__thiscall*)(void*)'),
	IsCloudEnabledForApp = steam_remotestorage:get_vfunc(22, 'bool(__thiscall*)(void*)'),
	SetCloudEnabledForApp = steam_remotestorage:get_vfunc(23, 'void(__thiscall*)(void*, bool)'),
	UGCDownload = steam_remotestorage:get_vfunc(24, 'SteamAPICall_t(__thiscall*)(void*, UGCHandle_t, uint32)'),
	GetUGCDownloadProgress = steam_remotestorage:get_vfunc(25, 'bool(__thiscall*)(void*, UGCHandle_t, int32*, int32*)'),
	GetUGCDetails = steam_remotestorage:get_vfunc(26, 'bool(__thiscall*)(void*, UGCHandle_t, AppId_t*, char*, int32*, CSteamID*)'),
	UGCRead = steam_remotestorage:get_vfunc(27, 'int32(__thiscall*)(void*, UGCHandle_t, void*, int32, uint32, EUGCReadAction)'),
	GetCachedUGCCount = steam_remotestorage:get_vfunc(28, 'int32(__thiscall*)(void*)'),
	GetCachedUGCHandle = steam_remotestorage:get_vfunc(29, 'UGCHandle_t(__thiscall*)(void*, int32)'),
	PublishWorkshopFile = steam_remotestorage:get_vfunc(30, 'SteamAPICall_t(__thiscall*)(void*, const char*, const char*, AppId_t, const char*, const char*, ERemoteStoragePublishedFileVisibility, SteamParamStringArray_t*, EWorkshopFileType)'),
	CreatePublishedFileUpdateRequest = steam_remotestorage:get_vfunc(31, 'PublishedFileUpdateHandle_t(__thiscall*)(void*, PublishedFileId_t)'),
	UpdatePublishedFileFile = steam_remotestorage:get_vfunc(32, 'bool(__thiscall*)(void*, PublishedFileUpdateHandle_t, const char*)'),
	UpdatePublishedFilePreviewFile = steam_remotestorage:get_vfunc(33, 'bool(__thiscall*)(void*, PublishedFileUpdateHandle_t, const char*)'),
	UpdatePublishedFileTitle = steam_remotestorage:get_vfunc(34, 'bool(__thiscall*)(void*, PublishedFileUpdateHandle_t, const char*)'),
	UpdatePublishedFileDescription = steam_remotestorage:get_vfunc(35, 'bool(__thiscall*)(void*, PublishedFileUpdateHandle_t, const char*)'),
	UpdatePublishedFileVisibility = steam_remotestorage:get_vfunc(36, 'bool(__thiscall*)(void*, PublishedFileUpdateHandle_t, ERemoteStoragePublishedFileVisibility)'),
	UpdatePublishedFileTags = steam_remotestorage:get_vfunc(37, 'bool(__thiscall*)(void*, PublishedFileUpdateHandle_t, SteamParamStringArray_t*)'),
	CommitPublishedFileUpdate = steam_remotestorage:get_vfunc(38, 'SteamAPICall_t(__thiscall*)(void*, PublishedFileUpdateHandle_t)'),
	GetPublishedFileDetails = steam_remotestorage:get_vfunc(39, 'SteamAPICall_t(__thiscall*)(void*, PublishedFileId_t, uint32)'),
	DeletePublishedFile = steam_remotestorage:get_vfunc(40, 'SteamAPICall_t(__thiscall*)(void*, PublishedFileId_t)'),
	EnumerateUserPublishedFiles = steam_remotestorage:get_vfunc(41, 'SteamAPICall_t(__thiscall*)(void*, uint32)'),
	SubscribePublishedFile = steam_remotestorage:get_vfunc(42, 'SteamAPICall_t(__thiscall*)(void*, PublishedFileId_t)'),
	EnumerateUserSubscribedFiles = steam_remotestorage:get_vfunc(43, 'SteamAPICall_t(__thiscall*)(void*, uint32)'),
	UnsubscribePublishedFile = steam_remotestorage:get_vfunc(44, 'SteamAPICall_t(__thiscall*)(void*, PublishedFileId_t)'),
	UpdatePublishedFileSetChangeDescription = steam_remotestorage:get_vfunc(45, 'bool(__thiscall*)(void*, PublishedFileUpdateHandle_t, const char*)'),
	GetPublishedItemVoteDetails = steam_remotestorage:get_vfunc(46, 'SteamAPICall_t(__thiscall*)(void*, PublishedFileId_t)'),
	UpdateUserPublishedItemVote = steam_remotestorage:get_vfunc(47, 'SteamAPICall_t(__thiscall*)(void*, PublishedFileId_t, bool)'),
	GetUserPublishedItemVoteDetails = steam_remotestorage:get_vfunc(48, 'SteamAPICall_t(__thiscall*)(void*, PublishedFileId_t)'),
	EnumerateUserSharedWorkshopFiles = steam_remotestorage:get_vfunc(49, 'SteamAPICall_t(__thiscall*)(void*, CSteamID, uint32, SteamParamStringArray_t*, SteamParamStringArray_t*)'),
	PublishVideo = steam_remotestorage:get_vfunc(50, 'SteamAPICall_t(__thiscall*)(void*, EWorkshopVideoProvider, const char*, const char*, const char*, AppId_t, const char*, const char*, ERemoteStoragePublishedFileVisibility, SteamParamStringArray_t*)'),
	SetUserPublishedFileAction = steam_remotestorage:get_vfunc(51, 'SteamAPICall_t(__thiscall*)(void*, PublishedFileId_t, EWorkshopFileAction)'),
	EnumeratePublishedFilesByUserAction = steam_remotestorage:get_vfunc(52, 'SteamAPICall_t(__thiscall*)(void*, EWorkshopFileAction, uint32)'),
	EnumeratePublishedWorkshopFiles = steam_remotestorage:get_vfunc(53, 'SteamAPICall_t(__thiscall*)(void*, EWorkshopEnumerationType, uint32, uint32, uint32, SteamParamStringArray_t*, SteamParamStringArray_t*)'),
	UGCDownloadToLocation = steam_remotestorage:get_vfunc(54, 'SteamAPICall_t(__thiscall*)(void*, UGCHandle_t, const char*, uint32)'),
}
api_mt.ISteamRemoteStorage = ISteamRemoteStorage_mt

local steam_screenshots = helper.get_class(steam_api.steam_screenshots)
local ISteamScreenshots_mt = {
	raw = steam_screenshots,
	WriteScreenshot = steam_screenshots:get_vfunc(0, 'ScreenshotHandle(__thiscall*)(void*, void*, uint32, int, int)'),
	AddScreenshotToLibrary = steam_screenshots:get_vfunc(1, 'ScreenshotHandle(__thiscall*)(void*, const char*, const char*, int, int)'),
	TriggerScreenshot = steam_screenshots:get_vfunc(2, 'void(__thiscall*)(void*)'),
	HookScreenshots = steam_screenshots:get_vfunc(3, 'void(__thiscall*)(void*, bool)'),
	SetLocation = steam_screenshots:get_vfunc(4, 'bool(__thiscall*)(void*, ScreenshotHandle, const char*)'),
	TagUser = steam_screenshots:get_vfunc(5, 'bool(__thiscall*)(void*, ScreenshotHandle, CSteamID)'),
	TagPublishedFile = steam_screenshots:get_vfunc(6, 'bool(__thiscall*)(void*, ScreenshotHandle, PublishedFileId_t)'),
	IsScreenshotsHooked = steam_screenshots:get_vfunc(7, 'bool(__thiscall*)(void*)'),
	AddVRScreenshotToLibrary = steam_screenshots:get_vfunc(8, 'ScreenshotHandle(__thiscall*)(void*, EVRScreenshotType, const char*, const char*)'),
}
api_mt.ISteamScreenshots = ISteamScreenshots_mt

local steam_http = helper.get_class(steam_api.steam_http)
local ISteamHTTP_mt = {
	raw = steam_http,
	CreateHTTPRequest = steam_http:get_vfunc(0, 'HTTPRequestHandle(__thiscall*)(void*, EHTTPMethod, const char*)'),
	SetHTTPRequestContextValue = steam_http:get_vfunc(1, 'bool(__thiscall*)(void*, HTTPRequestHandle, uint64)'),
	SetHTTPRequestNetworkActivityTimeout = steam_http:get_vfunc(2, 'bool(__thiscall*)(void*, HTTPRequestHandle, uint32)'),
	SetHTTPRequestHeaderValue = steam_http:get_vfunc(3, 'bool(__thiscall*)(void*, HTTPRequestHandle, const char*, const char*)'),
	SetHTTPRequestGetOrPostParameter = steam_http:get_vfunc(4, 'bool(__thiscall*)(void*, HTTPRequestHandle, const char*, const char*)'),
	SendHTTPRequest = steam_http:get_vfunc(5, 'bool(__thiscall*)(void*, HTTPRequestHandle, SteamAPICall_t*)'),
	SendHTTPRequestAndStreamResponse = steam_http:get_vfunc(6, 'bool(__thiscall*)(void*, HTTPRequestHandle, SteamAPICall_t*)'),
	DeferHTTPRequest = steam_http:get_vfunc(7, 'bool(__thiscall*)(void*, HTTPRequestHandle)'),
	PrioritizeHTTPRequest = steam_http:get_vfunc(8, 'bool(__thiscall*)(void*, HTTPRequestHandle)'),
	GetHTTPResponseHeaderSize = steam_http:get_vfunc(9, 'bool(__thiscall*)(void*, HTTPRequestHandle, const char*, uint32*)'),
	GetHTTPResponseHeaderValue = steam_http:get_vfunc(10, 'bool(__thiscall*)(void*, HTTPRequestHandle, const char*, uint8*, uint32)'),
	GetHTTPResponseBodySize = steam_http:get_vfunc(11, 'bool(__thiscall*)(void*, HTTPRequestHandle, uint32*)'),
	GetHTTPResponseBodyData = steam_http:get_vfunc(12, 'bool(__thiscall*)(void*, HTTPRequestHandle, uint8*, uint32)'),
	GetHTTPStreamingResponseBodyData = steam_http:get_vfunc(13, 'bool(__thiscall*)(void*, HTTPRequestHandle, uint32, uint8*, uint32)'),
	ReleaseHTTPRequest = steam_http:get_vfunc(14, 'bool(__thiscall*)(void*, HTTPRequestHandle)'),
	GetHTTPDownloadProgressPct = steam_http:get_vfunc(15, 'bool(__thiscall*)(void*, HTTPRequestHandle, float*)'),
	SetHTTPRequestRawPostBody = steam_http:get_vfunc(16, 'bool(__thiscall*)(void*, HTTPRequestHandle, const char*, uint8*, uint32)'),
	CreateCookieContainer = steam_http:get_vfunc(17, 'HTTPCookieContainerHandle(__thiscall*)(void*, bool)'),
	ReleaseCookieContainer = steam_http:get_vfunc(18, 'bool(__thiscall*)(void*, HTTPCookieContainerHandle)'),
	SetCookie = steam_http:get_vfunc(19, 'bool(__thiscall*)(void*, HTTPCookieContainerHandle, const char*, const char*, const char*)'),
	SetHTTPRequestCookieContainer = steam_http:get_vfunc(20, 'bool(__thiscall*)(void*, HTTPRequestHandle, HTTPCookieContainerHandle)'),
	SetHTTPRequestUserAgentInfo = steam_http:get_vfunc(21, 'bool(__thiscall*)(void*, HTTPRequestHandle, const char*)'),
	SetHTTPRequestRequiresVerifiedCertificate = steam_http:get_vfunc(22, 'bool(__thiscall*)(void*, HTTPRequestHandle, bool)'),
	SetHTTPRequestAbsoluteTimeoutMS = steam_http:get_vfunc(23, 'bool(__thiscall*)(void*, HTTPRequestHandle, uint32)'),
	GetHTTPRequestWasTimedOut = steam_http:get_vfunc(24, 'bool(__thiscall*)(void*, HTTPRequestHandle, bool*)'),
}
api_mt.ISteamHTTP = ISteamHTTP_mt

local steam_controller = helper.get_class(steam_api.steam_controller)
local ISteamController_mt = {
	raw = steam_controller,
	Init = steam_controller:get_vfunc(0, 'bool(__thiscall*)(void*)'),
	Shutdown = steam_controller:get_vfunc(1, 'bool(__thiscall*)(void*)'),
	RunFrame = steam_controller:get_vfunc(2, 'void(__thiscall*)(void*)'),
	GetConnectedControllers = steam_controller:get_vfunc(3, 'int(__thiscall*)(void*, ControllerHandle_t*)'),
	GetActionSetHandle = steam_controller:get_vfunc(4, 'ControllerActionSetHandle_t(__thiscall*)(void*, const char*)'),
	ActivateActionSet = steam_controller:get_vfunc(5, 'void(__thiscall*)(void*, ControllerHandle_t, ControllerActionSetHandle_t)'),
	GetCurrentActionSet = steam_controller:get_vfunc(6, 'ControllerActionSetHandle_t(__thiscall*)(void*, ControllerHandle_t)'),
	ActivateActionSetLayer = steam_controller:get_vfunc(7, 'void(__thiscall*)(void*, ControllerHandle_t, ControllerActionSetHandle_t)'),
	DeactivateActionSetLayer = steam_controller:get_vfunc(8, 'void(__thiscall*)(void*, ControllerHandle_t, ControllerActionSetHandle_t)'),
	DeactivateAllActionSetLayers = steam_controller:get_vfunc(9, 'void(__thiscall*)(void*, ControllerHandle_t)'),
	GetActiveActionSetLayers = steam_controller:get_vfunc(10, 'int(__thiscall*)(void*, ControllerHandle_t, ControllerActionSetHandle_t*)'),
	GetDigitalActionHandle = steam_controller:get_vfunc(11, 'ControllerDigitalActionHandle_t(__thiscall*)(void*, const char*)'),
	GetDigitalActionData = steam_controller:get_vfunc(12, 'ControllerDigitalActionData_t(__thiscall*)(void*, ControllerHandle_t, ControllerDigitalActionHandle_t)'),
	GetDigitalActionOrigins = steam_controller:get_vfunc(13, 'int(__thiscall*)(void*, ControllerHandle_t, ControllerActionSetHandle_t, ControllerDigitalActionHandle_t, EControllerActionOrigin*)'),
	GetAnalogActionHandle = steam_controller:get_vfunc(14, 'ControllerAnalogActionHandle_t(__thiscall*)(void*, const char*)'),
	GetAnalogActionData = steam_controller:get_vfunc(15, 'ControllerAnalogActionData_t(__thiscall*)(void*, ControllerHandle_t, ControllerAnalogActionHandle_t)'),
	GetAnalogActionOrigins = steam_controller:get_vfunc(16, 'int(__thiscall*)(void*, ControllerHandle_t, ControllerActionSetHandle_t, ControllerAnalogActionHandle_t, EControllerActionOrigin*)'),
	GetGlyphForActionOrigin = steam_controller:get_vfunc(17, 'const char*(__thiscall*)(void*, EControllerActionOrigin)'),
	GetStringForActionOrigin = steam_controller:get_vfunc(18, 'const char*(__thiscall*)(void*, EControllerActionOrigin)'),
	StopAnalogActionMomentum = steam_controller:get_vfunc(19, 'void(__thiscall*)(void*, ControllerHandle_t, ControllerAnalogActionHandle_t)'),
	GetMotionData = steam_controller:get_vfunc(20, 'ControllerMotionData_t(__thiscall*)(void*, ControllerHandle_t)'),
	TriggerHapticPulse = steam_controller:get_vfunc(21, 'void(__thiscall*)(void*, ControllerHandle_t, ESteamControllerPad, unsigned short)'),
	TriggerRepeatedHapticPulse = steam_controller:get_vfunc(22, 'void(__thiscall*)(void*, ControllerHandle_t, ESteamControllerPad, unsigned short, unsigned short, unsigned short, unsigned int)'),
	TriggerVibration = steam_controller:get_vfunc(23, 'void(__thiscall*)(void*, ControllerHandle_t, unsigned short, unsigned short)'),
	SetLEDColor = steam_controller:get_vfunc(24, 'void(__thiscall*)(void*, ControllerHandle_t, uint8, uint8, uint8, unsigned int)'),
	ShowBindingPanel = steam_controller:get_vfunc(25, 'bool(__thiscall*)(void*, ControllerHandle_t)'),
	--GetInputTypeForHandle = steam_controller:get_vfunc(26, 'ESteamInputType(__thiscall*)(void*)'), -- throws invalid index error?!
	GetControllerForGamepadIndex = steam_controller:get_vfunc(27, 'ControllerHandle_t(__thiscall*)(void*, int)'),
	GetGamepadIndexForController = steam_controller:get_vfunc(28, 'int(__thiscall*)(void*, ControllerHandle_t)'),
	GetStringForXboxOrigin = steam_controller:get_vfunc(29, 'const char*(__thiscall*)(void*, EXboxOrigin)'),
	GetGlyphForXboxOrigin = steam_controller:get_vfunc(30, 'const char*(__thiscall*)(void*, EXboxOrigin)'),
	GetActionOriginFromXboxOrigin = steam_controller:get_vfunc(31, 'EControllerActionOrigin(__thiscall*)(void*, ControllerHandle_t, EXboxOrigin)'),
	TranslateActionOrigin = steam_controller:get_vfunc(32, 'EControllerActionOrigin(__thiscall*)(void*, ESteamInputType, EControllerActionOrigin)'),
}
api_mt.ISteamController = ISteamController_mt

local steam_ugc = helper.get_class(steam_api.steam_ugc)
local ISteamUGC_mt = {
	raw = steam_ugc,
	CreateQueryUserUGCRequest = steam_ugc:get_vfunc(0, 'UGCQueryHandle_t(__thiscall*)(void*, AccountID_t, EUserUGCList, EUGCMatchingUGCType, EUserUGCListSortOrder, AppId_t, AppId_t, uint32)'),
	CreateQueryAllUGCRequest = steam_ugc:get_vfunc(1, 'UGCQueryHandle_t(__thiscall*)(void*, EUGCQuery, EUGCMatchingUGCType, AppId_t, AppId_t, uint32)'),
	CreateQueryAllUGCRequest = steam_ugc:get_vfunc(2, 'UGCQueryHandle_t(__thiscall*)(void*, EUGCQuery, EUGCMatchingUGCType, AppId_t, AppId_t, const char*)'),
	CreateQueryUGCDetailsRequest = steam_ugc:get_vfunc(3, 'UGCQueryHandle_t(__thiscall*)(void*, PublishedFileId_t*, uint32)'),
	SendQueryUGCRequest = steam_ugc:get_vfunc(4, 'SteamAPICall_t(__thiscall*)(void*, UGCQueryHandle_t)'),
	GetQueryUGCResult = steam_ugc:get_vfunc(5, 'bool(__thiscall*)(void*, UGCQueryHandle_t, uint32, SteamUGCDetails_t*)'),
	GetQueryUGCPreviewURL = steam_ugc:get_vfunc(6, 'bool(__thiscall*)(void*, UGCQueryHandle_t, uint32, char*, uint32)'),
	GetQueryUGCMetadata = steam_ugc:get_vfunc(7, 'bool(__thiscall*)(void*, UGCQueryHandle_t, uint32, char*, uint32)'),
	GetQueryUGCChildren = steam_ugc:get_vfunc(8, 'bool(__thiscall*)(void*, UGCQueryHandle_t, uint32, PublishedFileId_t*, uint32)'),
	GetQueryUGCStatistic = steam_ugc:get_vfunc(9, 'bool(__thiscall*)(void*, UGCQueryHandle_t, uint32, EItemStatistic, uint64*)'),
	GetQueryUGCNumAdditionalPreviews = steam_ugc:get_vfunc(10, 'uint32(__thiscall*)(void*, UGCQueryHandle_t, uint32)'),
	GetQueryUGCAdditionalPreview = steam_ugc:get_vfunc(11, 'bool(__thiscall*)(void*, UGCQueryHandle_t, uint32, uint32, char*, uint32, char*, uint32, EItemPreviewType*)'),
	GetQueryUGCNumKeyValueTags = steam_ugc:get_vfunc(12, 'uint32(__thiscall*)(void*, UGCQueryHandle_t, uint32)'),
	GetQueryUGCKeyValueTag = steam_ugc:get_vfunc(13, 'bool(__thiscall*)(void*, UGCQueryHandle_t, uint32, uint32, char*, uint32, char*, uint32)'),
	ReleaseQueryUGCRequest = steam_ugc:get_vfunc(14, 'bool(__thiscall*)(void*, UGCQueryHandle_t)'),
	AddRequiredTag = steam_ugc:get_vfunc(15, 'bool(__thiscall*)(void*, UGCQueryHandle_t, const char*)'),
	AddExcludedTag = steam_ugc:get_vfunc(16, 'bool(__thiscall*)(void*, UGCQueryHandle_t, const char*)'),
	SetReturnOnlyIDs = steam_ugc:get_vfunc(17, 'bool(__thiscall*)(void*, UGCQueryHandle_t, bool)'),
	SetReturnKeyValueTags = steam_ugc:get_vfunc(18, 'bool(__thiscall*)(void*, UGCQueryHandle_t, bool)'),
	SetReturnLongDescription = steam_ugc:get_vfunc(19, 'bool(__thiscall*)(void*, UGCQueryHandle_t, bool)'),
	SetReturnMetadata = steam_ugc:get_vfunc(20, 'bool(__thiscall*)(void*, UGCQueryHandle_t, bool)'),
	SetReturnChildren = steam_ugc:get_vfunc(21, 'bool(__thiscall*)(void*, UGCQueryHandle_t, bool)'),
	SetReturnAdditionalPreviews = steam_ugc:get_vfunc(22, 'bool(__thiscall*)(void*, UGCQueryHandle_t, bool)'),
	SetReturnTotalOnly = steam_ugc:get_vfunc(23, 'bool(__thiscall*)(void*, UGCQueryHandle_t, bool)'),
	SetReturnPlaytimeStats = steam_ugc:get_vfunc(24, 'bool(__thiscall*)(void*, UGCQueryHandle_t, uint32)'),
	SetLanguage = steam_ugc:get_vfunc(25, 'bool(__thiscall*)(void*, UGCQueryHandle_t, const char*)'),
	SetAllowCachedResponse = steam_ugc:get_vfunc(26, 'bool(__thiscall*)(void*, UGCQueryHandle_t, uint32)'),
	SetCloudFileNameFilter = steam_ugc:get_vfunc(27, 'bool(__thiscall*)(void*, UGCQueryHandle_t, const char*)'),
	SetMatchAnyTag = steam_ugc:get_vfunc(28, 'bool(__thiscall*)(void*, UGCQueryHandle_t, bool)'),
	SetSearchText = steam_ugc:get_vfunc(29, 'bool(__thiscall*)(void*, UGCQueryHandle_t, const char*)'),
	SetRankedByTrendDays = steam_ugc:get_vfunc(30, 'bool(__thiscall*)(void*, UGCQueryHandle_t, uint32)'),
	AddRequiredKeyValueTag = steam_ugc:get_vfunc(31, 'bool(__thiscall*)(void*, UGCQueryHandle_t, const char*, const char*)'),
	RequestUGCDetails = steam_ugc:get_vfunc(32, 'SteamAPICall_t(__thiscall*)(void*, PublishedFileId_t, uint32)'),
	CreateItem = steam_ugc:get_vfunc(33, 'SteamAPICall_t(__thiscall*)(void*, AppId_t, EWorkshopFileType)'),
	StartItemUpdate = steam_ugc:get_vfunc(34, 'UGCUpdateHandle_t(__thiscall*)(void*, AppId_t, PublishedFileId_t)'),
	SetItemTitle = steam_ugc:get_vfunc(35, 'bool(__thiscall*)(void*, UGCUpdateHandle_t, const char*)'),
	SetItemDescription = steam_ugc:get_vfunc(36, 'bool(__thiscall*)(void*, UGCUpdateHandle_t, const char*)'),
	SetItemUpdateLanguage = steam_ugc:get_vfunc(37, 'bool(__thiscall*)(void*, UGCUpdateHandle_t, const char*)'),
	SetItemMetadata = steam_ugc:get_vfunc(38, 'bool(__thiscall*)(void*, UGCUpdateHandle_t, const char*)'),
	SetItemVisibility = steam_ugc:get_vfunc(39, 'bool(__thiscall*)(void*, UGCUpdateHandle_t, ERemoteStoragePublishedFileVisibility)'),
	SetItemTags = steam_ugc:get_vfunc(40, 'bool(__thiscall*)(void*, UGCUpdateHandle_t, const SteamParamStringArray_t*)'),
	SetItemContent = steam_ugc:get_vfunc(41, 'bool(__thiscall*)(void*, UGCUpdateHandle_t, const char*)'),
	SetItemPreview = steam_ugc:get_vfunc(42, 'bool(__thiscall*)(void*, UGCUpdateHandle_t, const char*)'),
	SetAllowLegacyUpload = steam_ugc:get_vfunc(43, 'bool(__thiscall*)(void*, UGCUpdateHandle_t, bool)'),
	RemoveItemKeyValueTags = steam_ugc:get_vfunc(44, 'bool(__thiscall*)(void*, UGCUpdateHandle_t, const char*)'),
	AddItemKeyValueTag = steam_ugc:get_vfunc(45, 'bool(__thiscall*)(void*, UGCUpdateHandle_t, const char*, const char*)'),
	AddItemPreviewFile = steam_ugc:get_vfunc(46, 'bool(__thiscall*)(void*, UGCUpdateHandle_t, const char*, EItemPreviewType)'),
	AddItemPreviewVideo = steam_ugc:get_vfunc(47, 'bool(__thiscall*)(void*, UGCUpdateHandle_t, const char*)'),
	UpdateItemPreviewFile = steam_ugc:get_vfunc(48, 'bool(__thiscall*)(void*, UGCUpdateHandle_t, uint32, const char*)'),
	UpdateItemPreviewVideo = steam_ugc:get_vfunc(49, 'bool(__thiscall*)(void*, UGCUpdateHandle_t, uint32, const char*)'),
	RemoveItemPreview = steam_ugc:get_vfunc(50, 'bool(__thiscall*)(void*, UGCUpdateHandle_t, uint32)'),
	SubmitItemUpdate = steam_ugc:get_vfunc(51, 'SteamAPICall_t(__thiscall*)(void*, UGCUpdateHandle_t, const char*)'),
	GetItemUpdateProgress = steam_ugc:get_vfunc(52, 'EItemUpdateStatus(__thiscall*)(void*, UGCUpdateHandle_t, uint64*, uint64*)'),
	SetUserItemVote = steam_ugc:get_vfunc(53, 'SteamAPICall_t(__thiscall*)(void*, PublishedFileId_t, bool)'),
	GetUserItemVote = steam_ugc:get_vfunc(54, 'SteamAPICall_t(__thiscall*)(void*, PublishedFileId_t)'),
	AddItemToFavorites = steam_ugc:get_vfunc(55, 'SteamAPICall_t(__thiscall*)(void*, AppId_t, PublishedFileId_t)'),
	RemoveItemFromFavorites = steam_ugc:get_vfunc(56, 'SteamAPICall_t(__thiscall*)(void*, AppId_t, PublishedFileId_t)'),
	SubscribeItem = steam_ugc:get_vfunc(57, 'SteamAPICall_t(__thiscall*)(void*, PublishedFileId_t)'),
	UnsubscribeItem = steam_ugc:get_vfunc(58, 'SteamAPICall_t(__thiscall*)(void*, PublishedFileId_t)'),
	GetNumSubscribedItems = steam_ugc:get_vfunc(59, 'uint32(__thiscall*)(void*)'),
	GetSubscribedItems = steam_ugc:get_vfunc(60, 'uint32(__thiscall*)(void*, PublishedFileId_t*, uint32)'),
	GetItemState = steam_ugc:get_vfunc(61, 'uint32(__thiscall*)(void*, PublishedFileId_t)'),
	GetItemInstallInfo = steam_ugc:get_vfunc(62, 'bool(__thiscall*)(void*, PublishedFileId_t, uint64*, char*, uint32, uint32*)'),
	GetItemDownloadInfo = steam_ugc:get_vfunc(63, 'bool(__thiscall*)(void*, PublishedFileId_t, uint64*, uint64*)'),
	DownloadItem = steam_ugc:get_vfunc(64, 'bool(__thiscall*)(void*, PublishedFileId_t, bool)'),
	BInitWorkshopForGameServer = steam_ugc:get_vfunc(65, 'bool(__thiscall*)(void*, DepotId_t, const char*)'),
	SuspendDownloads = steam_ugc:get_vfunc(66, 'void(__thiscall*)(void*, bool)'),
	StartPlaytimeTracking = steam_ugc:get_vfunc(67, 'SteamAPICall_t(__thiscall*)(void*, PublishedFileId_t*, uint32)'),
	StopPlaytimeTracking = steam_ugc:get_vfunc(68, 'SteamAPICall_t(__thiscall*)(void*, PublishedFileId_t*, uint32)'),
	StopPlaytimeTrackingForAllItems = steam_ugc:get_vfunc(69, 'SteamAPICall_t(__thiscall*)(void*)'),
	AddDependency = steam_ugc:get_vfunc(70, 'SteamAPICall_t(__thiscall*)(void*, PublishedFileId_t, PublishedFileId_t)'),
	RemoveDependency = steam_ugc:get_vfunc(71, 'SteamAPICall_t(__thiscall*)(void*, PublishedFileId_t, PublishedFileId_t)'),
	AddAppDependency = steam_ugc:get_vfunc(72, 'SteamAPICall_t(__thiscall*)(void*, PublishedFileId_t, AppId_t)'),
	RemoveAppDependency = steam_ugc:get_vfunc(73, 'SteamAPICall_t(__thiscall*)(void*, PublishedFileId_t, AppId_t)'),
	GetAppDependencies = steam_ugc:get_vfunc(74, 'SteamAPICall_t(__thiscall*)(void*, PublishedFileId_t)'),
	DeleteItem = steam_ugc:get_vfunc(75, 'SteamAPICall_t(__thiscall*)(void*, PublishedFileId_t)'),
}
api_mt.ISteamUGC = ISteamUGC_mt

local steam_applist = helper.get_class(steam_api.steam_applist)
local ISteamAppList_mt = {
	raw = steam_applist,
	GetNumInstalledApps = steam_applist:get_vfunc(0, 'uint32(__thiscall*)(void*)'),
	GetInstalledApps = steam_applist:get_vfunc(1, 'uint32(__thiscall*)(void*, AppId_t*, uint32)'),
	GetAppName = steam_applist:get_vfunc(2, 'int(__thiscall*)(void*, AppId_t, char*, int)'),
	GetAppInstallDir = steam_applist:get_vfunc(3, 'int(__thiscall*)(void*, AppId_t, char*, int)'),
	GetAppBuildId = steam_applist:get_vfunc(4, 'int(__thiscall*)(void*, AppId_t)'),
}
api_mt.ISteamAppList = ISteamAppList_mt

local steam_music = helper.get_class(steam_api.steam_music)
local ISteamMusic_mt = {
	raw = steam_music,
	BIsEnabled = steam_music:get_vfunc(0, 'bool(__thiscall*)(void*)'),
	BIsPlaying = steam_music:get_vfunc(1, 'bool(__thiscall*)(void*)'),
	GetPlaybackStatus = steam_music:get_vfunc(2, 'AudioPlayback_Status(__thiscall*)(void*)'),
	Play = steam_music:get_vfunc(3, 'void(__thiscall*)(void*)'),
	Pause = steam_music:get_vfunc(4, 'void(__thiscall*)(void*)'),
	PlayPrevious = steam_music:get_vfunc(5, 'void(__thiscall*)(void*)'),
	PlayNext = steam_music:get_vfunc(6, 'void(__thiscall*)(void*)'),
	SetVolume = steam_music:get_vfunc(7, 'void(__thiscall*)(void*, float)'),
	GetVolume = steam_music:get_vfunc(8, 'float(__thiscall*)(void*)'),
}
api_mt.ISteamMusic = ISteamMusic_mt

local steam_musicremote = helper.get_class(steam_api.steam_musicremote)
local ISteamMusicRemote_mt = {
	raw = steam_musicremote,
	RegisterSteamMusicRemote = steam_musicremote:get_vfunc(0, 'bool(__thiscall*)(void*, const char*)'),
	DeregisterSteamMusicRemote = steam_musicremote:get_vfunc(1, 'bool(__thiscall*)(void*)'),
	BIsCurrentMusicRemote = steam_musicremote:get_vfunc(2, 'bool(__thiscall*)(void*)'),
	BActivationSuccess = steam_musicremote:get_vfunc(3, 'bool(__thiscall*)(void*, bool)'),
	SetDisplayName = steam_musicremote:get_vfunc(4, 'bool(__thiscall*)(void*, const char*)'),
	SetPNGIcon_64x64 = steam_musicremote:get_vfunc(5, 'bool(__thiscall*)(void*, void*, uint32)'),
	EnablePlayPrevious = steam_musicremote:get_vfunc(6, 'bool(__thiscall*)(void*, bool)'),
	EnablePlayNext = steam_musicremote:get_vfunc(7, 'bool(__thiscall*)(void*, bool)'),
	EnableShuffled = steam_musicremote:get_vfunc(8, 'bool(__thiscall*)(void*, bool)'),
	EnableLooped = steam_musicremote:get_vfunc(9, 'bool(__thiscall*)(void*, bool)'),
	EnableQueue = steam_musicremote:get_vfunc(10, 'bool(__thiscall*)(void*, bool)'),
	EnablePlaylists = steam_musicremote:get_vfunc(11, 'bool(__thiscall*)(void*, bool)'),
	UpdatePlaybackStatus = steam_musicremote:get_vfunc(12, 'bool(__thiscall*)(void*, AudioPlayback_Status)'),
	UpdateShuffled = steam_musicremote:get_vfunc(13, 'bool(__thiscall*)(void*, bool)'),
	UpdateLooped = steam_musicremote:get_vfunc(14, 'bool(__thiscall*)(void*, bool)'),
	UpdateVolume = steam_musicremote:get_vfunc(15, 'bool(__thiscall*)(void*, float)'),
	CurrentEntryWillChange = steam_musicremote:get_vfunc(16, 'bool(__thiscall*)(void*)'),
	CurrentEntryIsAvailable = steam_musicremote:get_vfunc(17, 'bool(__thiscall*)(void*, bool)'),
	UpdateCurrentEntryText = steam_musicremote:get_vfunc(18, 'bool(__thiscall*)(void*, const char*)'),
	UpdateCurrentEntryElapsedSeconds = steam_musicremote:get_vfunc(19, 'bool(__thiscall*)(void*, int)'),
	UpdateCurrentEntryCoverArt = steam_musicremote:get_vfunc(20, 'bool(__thiscall*)(void*, void*, uint32)'),
	CurrentEntryDidChange = steam_musicremote:get_vfunc(21, 'bool(__thiscall*)(void*)'),
	QueueWillChange = steam_musicremote:get_vfunc(22, 'bool(__thiscall*)(void*)'),
	ResetQueueEntries = steam_musicremote:get_vfunc(23, 'bool(__thiscall*)(void*)'),
	SetQueueEntry = steam_musicremote:get_vfunc(24, 'bool(__thiscall*)(void*, int, int, const char*)'),
	SetCurrentQueueEntry = steam_musicremote:get_vfunc(25, 'bool(__thiscall*)(void*, int)'),
	QueueDidChange = steam_musicremote:get_vfunc(26, 'bool(__thiscall*)(void*)'),
	PlaylistWillChange = steam_musicremote:get_vfunc(27, 'bool(__thiscall*)(void*)'),
	ResetPlaylistEntries = steam_musicremote:get_vfunc(28, 'bool(__thiscall*)(void*)'),
	SetPlaylistEntry = steam_musicremote:get_vfunc(29, 'bool(__thiscall*)(void*, int, int, const char*)'),
	SetCurrentPlaylistEntry = steam_musicremote:get_vfunc(30, 'bool(__thiscall*)(void*, int)'),
	PlaylistDidChange = steam_musicremote:get_vfunc(31, 'bool(__thiscall*)(void*)'),
}
api_mt.ISteamMusicRemote = ISteamMusicRemote_mt

local steam_htmlsurface = helper.get_class(steam_api.steam_htmlsurface)
local ISteamHTMLSurface_mt = {
	raw = steam_htmlsurface,
	Init = steam_htmlsurface:get_vfunc(1, 'bool(__thiscall*)(void*)'),
	Shutdown = steam_htmlsurface:get_vfunc(2, 'bool(__thiscall*)(void*)'),
	CreateBrowser = steam_htmlsurface:get_vfunc(3, 'SteamAPICall_t(__thiscall*)(void*, const char*, const char*)'),
	RemoveBrowser = steam_htmlsurface:get_vfunc(4, 'void(__thiscall*)(void*, HHTMLBrowser)'),
	LoadURL = steam_htmlsurface:get_vfunc(5, 'void(__thiscall*)(void*, HHTMLBrowser, const char*, const char*)'),
	SetSize = steam_htmlsurface:get_vfunc(6, 'void(__thiscall*)(void*, HHTMLBrowser, uint32, uint32)'),
	StopLoad = steam_htmlsurface:get_vfunc(7, 'void(__thiscall*)(void*, HHTMLBrowser)'),
	Reload = steam_htmlsurface:get_vfunc(8, 'void(__thiscall*)(void*, HHTMLBrowser)'),
	GoBack = steam_htmlsurface:get_vfunc(9, 'void(__thiscall*)(void*, HHTMLBrowser)'),
	GoForward = steam_htmlsurface:get_vfunc(10, 'void(__thiscall*)(void*, HHTMLBrowser)'),
	AddHeader = steam_htmlsurface:get_vfunc(11, 'void(__thiscall*)(void*, HHTMLBrowser, const char*, const char*)'),
	ExecuteJavascript = steam_htmlsurface:get_vfunc(12, 'void(__thiscall*)(void*, HHTMLBrowser, const char*)'),
	MouseUp = steam_htmlsurface:get_vfunc(13, 'void(__thiscall*)(void*, HHTMLBrowser, EHTMLMouseButton)'),
	MouseDown = steam_htmlsurface:get_vfunc(14, 'void(__thiscall*)(void*, HHTMLBrowser, EHTMLMouseButton)'),
	MouseDoubleClick = steam_htmlsurface:get_vfunc(15, 'void(__thiscall*)(void*, HHTMLBrowser, EHTMLMouseButton)'),
	MouseMove = steam_htmlsurface:get_vfunc(16, 'void(__thiscall*)(void*, HHTMLBrowser, int, int)'),
	MouseWheel = steam_htmlsurface:get_vfunc(17, 'void(__thiscall*)(void*, HHTMLBrowser, int32)'),
	KeyDown = steam_htmlsurface:get_vfunc(18, 'void(__thiscall*)(void*, HHTMLBrowser, uint32, EHTMLKeyModifiers, bool)'),
	KeyUp = steam_htmlsurface:get_vfunc(19, 'void(__thiscall*)(void*, HHTMLBrowser, uint32, EHTMLKeyModifiers)'),
	KeyChar = steam_htmlsurface:get_vfunc(20, 'void(__thiscall*)(void*, HHTMLBrowser, uint32, EHTMLKeyModifiers)'),
	SetHorizontalScroll = steam_htmlsurface:get_vfunc(21, 'void(__thiscall*)(void*, HHTMLBrowser, uint32)'),
	SetVerticalScroll = steam_htmlsurface:get_vfunc(22, 'void(__thiscall*)(void*, HHTMLBrowser, uint32)'),
	SetKeyFocus = steam_htmlsurface:get_vfunc(23, 'void(__thiscall*)(void*, HHTMLBrowser, bool)'),
	ViewSource = steam_htmlsurface:get_vfunc(24, 'void(__thiscall*)(void*, HHTMLBrowser)'),
	CopyToClipboard = steam_htmlsurface:get_vfunc(25, 'void(__thiscall*)(void*, HHTMLBrowser)'),
	PasteFromClipboard = steam_htmlsurface:get_vfunc(26, 'void(__thiscall*)(void*, HHTMLBrowser)'),
	Find = steam_htmlsurface:get_vfunc(27, 'void(__thiscall*)(void*, HHTMLBrowser, const char*, bool, bool)'),
	StopFind = steam_htmlsurface:get_vfunc(28, 'void(__thiscall*)(void*, HHTMLBrowser)'),
	GetLinkAtPosition = steam_htmlsurface:get_vfunc(29, 'void(__thiscall*)(void*, HHTMLBrowser, int, int)'),
	SetCookie = steam_htmlsurface:get_vfunc(30, 'void(__thiscall*)(void*, const char*, const char*, const char*, const char*, RTime32, bool, bool)'),
	SetPageScaleFactor = steam_htmlsurface:get_vfunc(31, 'void(__thiscall*)(void*, HHTMLBrowser, float, int, int)'),
	SetBackgroundMode = steam_htmlsurface:get_vfunc(32, 'void(__thiscall*)(void*, HHTMLBrowser, bool)'),
	SetDPIScalingFactor = steam_htmlsurface:get_vfunc(33, 'void(__thiscall*)(void*, HHTMLBrowser, float)'),
	OpenDeveloperTools = steam_htmlsurface:get_vfunc(34, 'void(__thiscall*)(void*, HHTMLBrowser)'),
	AllowStartRequest = steam_htmlsurface:get_vfunc(35, 'void(__thiscall*)(void*, HHTMLBrowser, bool)'),
	JSDialogResponse = steam_htmlsurface:get_vfunc(36, 'void(__thiscall*)(void*, HHTMLBrowser, bool)'),
	FileLoadDialogResponse = steam_htmlsurface:get_vfunc(37, 'void(__thiscall*)(void*, HHTMLBrowser, const char*)'),
}
api_mt.ISteamHTMLSurface = ISteamHTMLSurface_mt

local steam_inventory = helper.get_class(steam_api.steam_inventory)
local ISteamInventory_mt = {
	raw = steam_inventory,
	GetResultStatus = steam_inventory:get_vfunc(0, 'EResult(__thiscall*)(void*, SteamInventoryResult_t)'),
	GetResultItems = steam_inventory:get_vfunc(1, 'bool(__thiscall*)(void*, SteamInventoryResult_t)'),
	GetResultItemProperty = steam_inventory:get_vfunc(2, 'bool(__thiscall*)(void*, SteamInventoryResult_t)'),
	GetResultTimestamp = steam_inventory:get_vfunc(3, 'uint32(__thiscall*)(void*, SteamInventoryResult_t)'),
	CheckResultSteamID = steam_inventory:get_vfunc(4, 'bool(__thiscall*)(void*, SteamInventoryResult_t, CSteamID)'),
	DestroyResult = steam_inventory:get_vfunc(5, 'void(__thiscall*)(void*, SteamInventoryResult_t)'),
	GetAllItems = steam_inventory:get_vfunc(6, 'bool(__thiscall*)(void*, SteamInventoryResult_t*)'),
	GetItemsByID = steam_inventory:get_vfunc(7, 'bool(__thiscall*)(void*, SteamInventoryResult_t*, const SteamItemInstanceID_t*, uint32)'),
	SerializeResult = steam_inventory:get_vfunc(8, 'bool(__thiscall*)(void*, SteamInventoryResult_t, void*, uint32*)'),
	DeserializeResult = steam_inventory:get_vfunc(9, 'bool(__thiscall*)(void*, SteamInventoryResult_t*, const void*, uint32, bool)'),
	GenerateItems = steam_inventory:get_vfunc(10, 'bool(__thiscall*)(void*, SteamInventoryResult_t*, const SteamItemDef_t*, const uint32*, uint32)'),
	GrantPromoItems = steam_inventory:get_vfunc(11, 'bool(__thiscall*)(void*, SteamInventoryResult_t*)'),
	AddPromoItem = steam_inventory:get_vfunc(12, 'bool(__thiscall*)(void*, SteamInventoryResult_t*, SteamItemDef_t)'),
	AddPromoItems = steam_inventory:get_vfunc(13, 'bool(__thiscall*)(void*, SteamInventoryResult_t*, const SteamItemDef_t*, uint32)'),
	ConsumeItem = steam_inventory:get_vfunc(14, 'bool(__thiscall*)(void*, SteamInventoryResult_t*, SteamItemInstanceID_t, uint32)'),
	ExchangeItems = steam_inventory:get_vfunc(15, 'bool(__thiscall*)(void*, SteamInventoryResult_t*)'),
	TransferItemQuantity = steam_inventory:get_vfunc(16, 'bool(__thiscall*)(void*, SteamInventoryResult_t*, SteamItemInstanceID_t, uint32, SteamItemInstanceID_t)'),
	SendItemDropHeartbeat = steam_inventory:get_vfunc(17, 'void(__thiscall*)(void*)'),
	TriggerItemDrop = steam_inventory:get_vfunc(18, 'bool(__thiscall*)(void*, SteamInventoryResult_t*, SteamItemDef_t)'),
	TradeItems = steam_inventory:get_vfunc(19, 'bool(__thiscall*)(void*, SteamInventoryResult_t*, CSteamID)'),
	LoadItemDefinitions = steam_inventory:get_vfunc(20, 'bool(__thiscall*)(void*)'),
	GetItemDefinitionIDs = steam_inventory:get_vfunc(21, 'bool(__thiscall*)(void*)'),
	GetItemDefinitionProperty = steam_inventory:get_vfunc(22, 'bool(__thiscall*)(void*, SteamItemDef_t, const char*, char*, uint32*)'),
	RequestEligiblePromoItemDefinitionsIDs = steam_inventory:get_vfunc(23, 'SteamAPICall_t(__thiscall*)(void*, CSteamID)'),
	GetEligiblePromoItemDefinitionIDs = steam_inventory:get_vfunc(24, 'bool(__thiscall*)(void*, CSteamID, SteamItemDef_t*, uint32*)'),
	StartPurchase = steam_inventory:get_vfunc(25, 'SteamAPICall_t(__thiscall*)(void*, const SteamItemDef_t*, const uint32*, uint32)'),
	RequestPrices = steam_inventory:get_vfunc(26, 'SteamAPICall_t(__thiscall*)(void*)'),
	GetNumItemsWithPrices = steam_inventory:get_vfunc(27, 'uint32(__thiscall*)(void*)'),
	GetItemsWithPrices = steam_inventory:get_vfunc(28, 'bool(__thiscall*)(void*, SteamItemDef_t*, uint64*, uint64*, uint32)'),
	GetItemPrice = steam_inventory:get_vfunc(29, 'bool(__thiscall*)(void*, SteamItemDef_t, uint64*, uint64*)'),
	StartUpdateProperties = steam_inventory:get_vfunc(30, 'SteamInventoryUpdateHandle_t(__thiscall*)(void*)'),
	RemoveProperty = steam_inventory:get_vfunc(31, 'bool(__thiscall*)(void*, SteamInventoryUpdateHandle_t, SteamItemInstanceID_t, const char*)'),
	SetPropertyFloat = steam_inventory:get_vfunc(32, 'bool(__thiscall*)(void*, SteamInventoryUpdateHandle_t, SteamItemInstanceID_t, const char*, float)'),
	SetPropertyInt64 = steam_inventory:get_vfunc(33, 'bool(__thiscall*)(void*, SteamInventoryUpdateHandle_t, SteamItemInstanceID_t, const char*, int64)'),
	SetPropertyBool = steam_inventory:get_vfunc(34, 'bool(__thiscall*)(void*, SteamInventoryUpdateHandle_t, SteamItemInstanceID_t, const char*, bool)'),
	SetPropertyChar = steam_inventory:get_vfunc(35, 'bool(__thiscall*)(void*, SteamInventoryUpdateHandle_t, SteamItemInstanceID_t, const char*, const char*)'),
	SubmitUpdateProperties = steam_inventory:get_vfunc(36, 'bool(__thiscall*)(void*, SteamInventoryUpdateHandle_t, SteamInventoryResult_t*)'),
}
api_mt.ISteamInventory = ISteamInventory_mt

local steam_video = helper.get_class(steam_api.steam_video)
local ISteamVideo_mt = {
	raw = steam_video,
	GetVideoURL = steam_video:get_vfunc(0, 'void(__thiscall*)(void*, AppId_t)'),
	IsBroadcasting = steam_video:get_vfunc(1, 'bool(__thiscall*)(void*, int*)'),
	GetOPFSettings = steam_video:get_vfunc(2, 'void(__thiscall*)(void*, AppId_t)'),
	GetOPFStringForApp = steam_video:get_vfunc(3, 'bool(__thiscall*)(void*, AppId_t, char*, int32*)'),
}
api_mt.ISteamVideo = ISteamVideo_mt


return api_mt