{:user {:plugins [[lein-ancient "0.6.15"]
                  [lein-auto "0.1.3"]
                  [lein-autoreload "0.1.1"]
                  [lein-kibit "0.1.6"]
                  [lein-nvd "0.5.5"]
                  [venantius/ultra "0.5.2"]]}
        :dependencies [[org.clojure/tools.trace "0.7.9"]
                       [clj-stacktrace "0.2.8"]
                       [slamhound "1.5.5"]]
        :aliases {"slamhound" ["run" "-m" "slam.hound"]}
        :repl-options {:init (do
                               (alter-var-root #'*out* (constantly *out*))
                               (require '[clojure.tools.trace :refer [trace]]))
                       :caught clj-stacktrace.repl/pst+
                       :prompt (fn [ns]
                                 (str "\033[1;32m"
                                      ns "=>"
                                      "\033[0m "))}}

