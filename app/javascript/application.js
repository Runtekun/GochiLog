// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"

// アバタードロップダウン
document.addEventListener("turbo:load", function() {
  const avatarBtn = document.getElementById("avatar-btn");
  if (!avatarBtn) return;

  avatarBtn.addEventListener("click", function() {
    document.getElementById("dropdown-menu").classList.toggle("hidden");
  });
});

document.addEventListener("click", function(e) {
  const avatarWrapper = document.getElementById("avatar-wrapper");
  const dropdownMenu = document.getElementById("dropdown-menu");
  if (!avatarWrapper || !dropdownMenu) return;
  if (!avatarWrapper.contains(e.target)) {
    dropdownMenu.classList.add("hidden");
  }
});
