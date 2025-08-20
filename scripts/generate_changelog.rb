# frozen_string_literal: true

# Simple generator that creates CHANGELOG.md from the git history.
# It lists all non-merge commits in reverse chronological order.
module Scripts
  class GenerateChangelog
    HEADER = <<~MD
      # Changelog

      All notable changes to this project will be documented in this file.
      This file is auto-generated from git history.

    MD

    def self.run
      root = repo_root
      Dir.chdir(root) do
        log_output = capture(%w[git log --no-merges --date=short --pretty=format:%ad|%h|%s])
        lines = log_output.split("\n").map do |line|
          date, hash, subject = line.split('|', 3)
          next if subject.nil? || subject.strip.empty?
          "- #{date} #{hash} #{subject.strip}"
        end.compact

        content = HEADER.dup
        content << lines.join("\n")
        content << "\n" unless content.end_with?("\n")

        File.write(File.join(root, 'CHANGELOG.md'), content)
      end
    end

    def self.repo_root
      capture(%w[git rev-parse --show-toplevel]).strip
    rescue
      Dir.pwd
    end

    def self.capture(cmd)
      IO.popen(cmd, err: [:child, :out]) { |io| io.read }
    end
  end
end

if $PROGRAM_NAME == __FILE__
  Scripts::GenerateChangelog.run
end
