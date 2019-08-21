#!/usr/bin/env node
const puppeteer = require('puppeteer');

(async () => {
  const browser = await puppeteer.launch();
  const page = await browser.newPage();
  await page.goto('https://example.com');
  console.log ('navigated to example.com');

  await page.screenshot({path: 'example.png'});
  console.log ('saved screenshot to example.png');

  await browser.close();
})();
