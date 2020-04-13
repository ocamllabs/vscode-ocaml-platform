(** Provides functions for fetching prebuilt artifacts from Azure Pipelines *)

val getBuildId : unit -> (int, string) result Promise.t
(** Fetches id of the latest build *)

val getDownloadUrl : int -> (string, string) result Promise.t
(** Fetches download url for the given build id *)
