import ReactOnRails from 'react-on-rails';

import Card from '../bundles/Card/components/Card';

// This is how react_on_rails can see the Card in the browser.
ReactOnRails.register({
  Card,
});
console.log("Hello is loaded")
