(** Provides functions for fetching prebuilt artifacts from Azure Pipelines *)

(** Fetches id of the latest build *)
val getBuildId : unit -> (int, string) result Promise.t

(** Fetches download url for the given build id *)
val getDownloadUrl : int -> (string, string) result Promise.t
