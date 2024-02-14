import React from 'react'
import renderer from 'react-test-renderer';
import Hello from './Hello';
import { render } from '@testing-library/react';


test('My test', () => {
    // Write tests here
    const { getByText } = render(<Hello />);
    const messageElement = getByText(/Hello, Rails 7!/i);
    expect(messageElement).toBeInTheDocument();
});
